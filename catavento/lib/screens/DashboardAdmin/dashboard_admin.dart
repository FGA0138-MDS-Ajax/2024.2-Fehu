import 'dart:io';
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
import 'package:catavento/screens/DashboardAdmin/components/search.dart';
import 'package:catavento/screens/DashboardAdmin/components/demandCard.dart';

class DashBoardAdmin extends StatelessWidget {
  const DashBoardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(),
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

//Estrutura da pagina
class AddDemandPageAdminState extends State<AddDemandPageAdmin> {
  late final DemandaController demandaController;

  @override
  void initState() {
    // demandaController = DemandaController(context.read<DemandaBloc>());
    // demandaController.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Titulo
              Text(
                'Demandas atuais $formattedDate',
                style: TextStyle(
                    fontSize: 29.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF015C98)),
              ),

              SizedBox(height: 40),

              //Barra de pesquisa
              Search(),

              SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QuadroPrioridade(),
                  SizedBox(
                    width: 16,
                  ),
                  ListDemanda(),
                  SizedBox(
                    width: 16,
                  ),
                  QuadroGrafico()
                ],
              ),

              SizedBox(
                height: 37,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // demandaController.finalize();
  }
}

//Graficos
class QuadroGrafico extends StatefulWidget {
  const QuadroGrafico({super.key});

  @override
  State<QuadroGrafico> createState() {
    return QuadroGraficoState();
  }
}

//Graficos
class QuadroGraficoState extends State<QuadroGrafico> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemandaBloc, DemandaState>(
      // BACKEND (Fazer mudanças dentro do return Column() OK)
      buildWhen: (previous, current) => current is! FilterState,
      builder: (context, response) {
        final metaData = response.metaData;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Grafico 1
            Container(
                width: 340,
                height: 132,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Completas: ${metaData['completo']}\n"
                          "Restantes: ${metaData['restantes']}\n",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Total: ${metaData['total']}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ))),

            SizedBox(
              height: 20,
            ),

            Container(
                width: 340,
                height: 132,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 60.0),
                      child: Icon(
                        Icons.cake,
                        size: 80.0,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 25.0, right: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${metaData['fabricacao']}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Em fabricação",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )
                          ],
                        )),
                  ],
                )),

            SizedBox(
              height: 30,
            ),

            Container(
                width: 340,
                height: 132,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, left: 60.0),
                      child: Icon(
                        Icons.layers,
                        size: 80.0,
                        color: Color(0xFF015C98),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 25.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${metaData['espera']}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Em espera",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )
                          ],
                        )),
                  ],
                )),
          ],
        );
      },
    );
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
    return Container(
      padding: EdgeInsets.all(7.0),
      width: 499,
      height: 438,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          Expanded(child: BlocBuilder<DemandaBloc, DemandaState>(
            // BACKEND (fazer mudanças dentro do listview.builder OK)
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.databaseResponse.length,
                itemBuilder: (context, index) {
                  final demanda = state.databaseResponse[index];
                  return DemandCard(
                    nomeDemanda:
                        demanda['nomeDemanda'] ?? 'Nome não disponível',
                    status: demanda['status'] ?? 'Status não disponível',
                    codigo: demanda['codigo'] ?? 'Sem código',
                    descricao: demanda['descricao'] ?? 'Sem descricao',
                    id: demanda['id'],
                    imagemUrl: demanda['imagemUrl'] ?? '',
                    order: index,
                    bloc: context.read<DemandaBloc>(), // BACKEND
                  );
                },
              );
            },
          )),
          SizedBox(height: 16), // Espaço entre a lista e o botão
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
