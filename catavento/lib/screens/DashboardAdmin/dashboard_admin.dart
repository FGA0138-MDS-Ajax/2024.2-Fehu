import 'dart:io';
import 'package:catavento/screens/DashboardAdmin/components/demandCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// BACKEND
import 'package:catavento/bloc/demanda_bloc.dart';
import 'package:catavento/bloc/demanda_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/table_import/table_import.dart';
import '../../services/table_import/table_picker.dart';

// components
import 'package:catavento/shared/widgets/header.dart';
import 'package:catavento/shared/widgets/menu.dart';
import 'package:catavento/shared/widgets/dialog.dart';
import 'package:catavento/shared/widgets/inputs.dart';
import 'package:catavento/screens/DashboardAdmin/components/quadroPrioridade.dart';
import 'package:catavento/screens/DashboardAdmin/components/quadroGrafico.dart';
import 'package:catavento/screens/DashboardAdmin/components/search.dart';

class DashBoardAdmin extends StatelessWidget {
  const DashBoardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(title: 'Demandas atuais $formattedDate'),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF75CDF3), Color(0xFFB2E8FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(child: AddDemandPageAdmin()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF015C98),
        onPressed: () async {
          final filePath = await tablePicker();
          if (filePath != null) {
            await importExcelToSupabase(filePath);
          }
        },
        child: Icon(Icons.upload_file, color: Colors.white),
      ),
    );
  }
}

//Estrutura da pagina
class AddDemandPageAdmin extends StatefulWidget {
  const AddDemandPageAdmin({super.key});

  @override
  State<AddDemandPageAdmin> createState() {
    return AddDemandPageAdminState();
  }
}

class AddDemandPageAdminState extends State<AddDemandPageAdmin> {
  late final DemandaController demandaController;

  @override
  void initState() {
    super.initState();
    demandaController = DemandaController(context.read<DemandaBloc>());
    demandaController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtém o tamanho da tela

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Barra de Pesquisa
              Padding(
                padding: EdgeInsets.zero,
                child: Search(),
              ),
              SizedBox(height: 20),

              // Ajustando a altura com Flex/Expanded
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return constraints.maxWidth > 600
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ainda falta ajustar a responsividade desse quadro, além de q o design vai mudar
                              Flexible(
                                flex: 1,
                                child: QuadroPrioridade(),
                              ),
                              SizedBox(width: 15),
                              Flexible(
                                flex: 2,
                                child: ListDemanda(),
                              ),
                              SizedBox(width: 15),
                              Flexible(
                                flex: 1,
                                child: QuadroGrafico(),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: QuadroPrioridade(),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Expanded(
                                child: ListDemanda(),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Expanded(
                                child: QuadroGrafico(),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    demandaController.finalize();
    super.dispose();
  }
}

class ListDemanda extends StatefulWidget {
  const ListDemanda({super.key});

  @override
  State<ListDemanda> createState() {
    return ListDemandaState();
  }
}

class ListDemandaState extends State<ListDemanda> {
  File? foto;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Tamanho da tela
    return Container(
      padding: EdgeInsets.all(10.0),
      width: size.width * 0.9,
      height: size.height * 0.65,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<DemandaBloc, DemandaState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.databaseResponse.length,
                  itemBuilder: (context, index) {
                    final demanda = state.databaseResponse[index];
                    return DemandCard(
                      nomeDemanda:
                          demanda['nome_demanda'] ?? 'Nome não disponível',
                      status: demanda['status'] ?? 'Status não disponível',
                      codigo: demanda['codigo'] ?? 'Sem código',
                      descricao: demanda['descricao'] ?? 'Sem descricao',
                      id: demanda['id'],
                      imagemUrl: demanda['imagem_url'] ?? '',
                      order: index,
                      bloc: context.read<DemandaBloc>(), // BACKEND
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10), // Espaço entre a lista e o botão
          ButtonAddDemanda(
            bloc: context.read<DemandaBloc>(), // BACKEND
          ),
        ],
      ),
    );
  }
}

//ignore: must_be_immutable
class ButtonAddDemanda extends StatelessWidget {
  final DemandaBloc bloc; // BACKEND
  ButtonAddDemanda({
    super.key,
    required this.bloc, // BACKEND
  });

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  File? fotoSelecionada;

  Future<void> _selecionarFoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagemSelecionada = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 85,
    );

    if (imagemSelecionada != null) {
      fotoSelecionada = File(imagemSelecionada.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Foto selecionada com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 189,
      height: 47,
      child: ElevatedButton(
        onPressed: () {
          addInfoDemand(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF015C98),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22))),
        child: Text(
          "Adicionar Demanda",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> addInfoDemand(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return ReusableDialog(
            title: "Nova demanda",
            confirmBeforeClose: true,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InputTextField(
                          labelText: "Código",
                          hintText: "Código da demanda",
                          controller: _codigoController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Expanded(
                        child: InputTextField(
                          labelText: "Nome",
                          hintText: "Nome da demanda",
                          controller: _nomeController,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputTextField(
                        labelText: "Descrição",
                        hintText: "Digite a descrição",
                        controller: _descricaoController,
                        maxLines: 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _selecionarFoto(context);
                          },
                          child: const Text("Selecionar Foto"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_nomeController.text.isNotEmpty &&
                          _codigoController.text.isNotEmpty) {
                        bloc.add(DemandaCreate(
                          nomeDemanda: _nomeController.text,
                          codigo: _codigoController.text,
                          descricao: _descricaoController.text,
                          foto: fotoSelecionada,
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Por favor, preencha todos os campos"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF015C98),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      "Cadastrar demanda",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
