import 'dart:io';
import 'package:catavento/screens/DashboardAdmin/components/demandCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// BACKEND
import 'package:catavento/bloc/demanda/demanda_bloc.dart';
import 'package:catavento/bloc/demanda/demanda_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catavento/core/services/table_import/table_import.dart';
import 'package:catavento/core/services/table_import/table_picker.dart';

// components
import 'package:catavento/shared/widgets/header.dart';
import 'package:catavento/shared/widgets/menu.dart';
import 'package:catavento/shared/widgets/dialog.dart';
import 'package:catavento/shared/widgets/inputs.dart';
import 'package:catavento/shared/theme/colors.dart';
import 'package:catavento/screens/DashboardAdmin/components/filterWidget.dart';
import 'package:catavento/screens/DashboardAdmin/components/quadroGrafico.dart';
import 'package:catavento/screens/DashboardAdmin/components/search.dart';

class DashBoardAdmin extends StatelessWidget {
  const DashBoardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(
        title: 'Demandas atuais $formattedDate',
        historyButton: true,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white, // Cor fixa (branca)
            child: Center(child: AddDemandPageAdmin()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
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

  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    demandaController = DemandaController(context.read<DemandaBloc>());
    demandaController.initialize();
  }

  // Função chamada quando o filtro é alterado
  void handleFilterChange(String? filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Search(),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return constraints.maxWidth > 600
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: FilterWidget(
                                  onFilterChanged: handleFilterChange,
                                ),
                              ),
                              SizedBox(width: 15),
                              Flexible(
                                flex: 2,
                                child: ListDemanda(filter: selectedFilter),
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
                                child: FilterWidget(
                                  onFilterChanged: handleFilterChange,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Expanded(
                                child: ListDemanda(filter: selectedFilter),
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
    super.dispose();
    demandaController.finalize();
  }
}

class ListDemanda extends StatefulWidget {
  final String? filter; // Filtro que será aplicado

  const ListDemanda({super.key, this.filter});

  @override
  State<ListDemanda> createState() => ListDemandaState();
}

class ListDemandaState extends State<ListDemanda> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Tamanho da tela
    return Container(
      padding: EdgeInsets.all(10.0),
      width: size.width * 0.9,
      height: size.height * 0.65,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
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
                List<dynamic> filteredList = [];

                if (widget.filter != null && widget.filter!.isNotEmpty) {
                  // Normaliza o valor do filtro (remove espaços e converte para minúsculas)
                  final normalizedFilter =
                      widget.filter!.toLowerCase().replaceAll(' ', '');

                  // Filtra as demandas de acordo com a loja, insensível a maiúsculas e espaços
                  filteredList = state.databaseResponse.where((demanda) {
                    // Normaliza o valor da loja (remove espaços e converte para minúsculas)
                    final loja = (demanda['loja'] ?? '')
                        .toLowerCase()
                        .replaceAll(' ', '');
                    return loja
                        .contains(normalizedFilter); // Compara sem espaços
                  }).toList();
                } else {
                  // Se não houver filtro, exibe todas as demandas
                  filteredList = state.databaseResponse;
                }
                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final demanda = filteredList[index];
                    return DemandCard(
                      nomeDemanda:
                          demanda['nome_demanda'] ?? 'Nome não disponível',
                      status: demanda['status'] ?? 'Status não disponível',
                      codigo: demanda['produto_id'] ?? 'Sem código',
                      descricao: demanda['descricao'] ?? 'Sem descrição',
                      dataAdicao: demanda['data_adicao'],
                      prazo: demanda['prazo'] ?? demanda['data_adicao'],
                      id: demanda['id'],
                      imagemUrl: demanda['imagem_url'] ?? '',
                      order: index,
                      plataforma: demanda['loja'] ?? 'Sem plataforma',
                      bloc: context.read<DemandaBloc>(), // BACKEND
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),
          ButtonAddDemanda(bloc: context.read<DemandaBloc>()),
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
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _prazoController = TextEditingController();
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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.gradientDarkBlue, AppColors.gradientLightBlue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: ElevatedButton(
          onPressed: () {
            addInfoDemand(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: const Text(
            "Adicionar Demanda",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addInfoDemand(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return ReusableDialog(
            backgroundColor: AppColors.lightGray,
            title: "Adicionar Demanda",
            confirmBeforeClose: true,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              color: AppColors.gradientDarkBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Informações Gerais",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'FredokaOne',
                                color: AppColors.gradientDarkBlue,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Código",
                              style: TextStyle(
                                  color: AppColors.gradientDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: InputTextField(
                                labelText: "",
                                hintText: "Código da demanda",
                                controller: _codigoController,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Nome",
                              style: TextStyle(
                                  color: AppColors.gradientDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputTextField(
                                hintText: "Nome da demanda",
                                controller: _nomeController,
                                labelText: '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Data do pedido",
                              style: TextStyle(
                                  color: AppColors.gradientDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: inputDate(_dataController),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Prazo",
                              style: TextStyle(
                                  color: AppColors.gradientDarkBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: inputDate(_prazoController),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.search,
                              color: AppColors.gradientDarkBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Informações Adicionais",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'FredokaOne',
                                color: AppColors.gradientDarkBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        InputTextField(
                          labelText: "Descrição",
                          hintText: "Digite a descrição",
                          controller: _descricaoController,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          _selecionarFoto(context);
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 18, // Ícone de câmera
                          color: Colors.white, // Cor do ícone (branco)
                        ),
                        label: const Text(
                          "Selecionar Foto",
                          style: TextStyle(
                            fontFamily: 'FredokaOne',
                            color: Colors.white, // Cor do texto (branca)
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.gradientDarkBlue, // Cor de fundo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                22), // Bordas arredondadas
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_codigoController.text.isNotEmpty ||
                          _nomeController.text.isNotEmpty) {
                        bloc.add(DemandaCreate(
                          nomeDemanda: _nomeController.text,
                          codigo: _codigoController.text,
                          descricao: _descricaoController.text,
                          foto: fotoSelecionada,
                          data: _dataController.text,
                          prazo: _prazoController.text,
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Por favor, preencha pelo menos o código ou nome do bolo"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gradientDarkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      "Concluir",
                      style: TextStyle(
                          fontFamily: 'FredokaOne', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
