import 'package:catavento/bloc/produto/produto_bloc.dart';
import 'package:catavento/screens/DashboardAdmin/components/demandCard.dart';
import 'package:catavento/screens/DashboardAdmin/components/dropDownLoja.dart';
import 'package:catavento/shared/widgets/bloc_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    context.read<DemandaBloc>().add(DemandaLoading());

    return Scaffold(
      drawer: Navbar(),
      appBar: CustomHeader(
        title: 'Demandas atuais $formattedDate',
        historyButton: false,
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
            final message = await importExcelToSupabase(filePath);
            if (context.mounted) {
              showBlocSnackbar(context, message, postFrameCallBack: false);
            }
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
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
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
  }
}

class ListDemanda extends StatefulWidget {
  final String? filter; // Filtro que será aplicado

  const ListDemanda({super.key, this.filter});

  @override
  State<ListDemanda> createState() => ListDemandaState();
}

class ListDemandaState extends State<ListDemanda> {
  late final DemandaController demandaController;

  @override
  void initState() {
    super.initState();
    demandaController = DemandaController(context.read<DemandaBloc>());
    demandaController.initialize();
  }

  @override
  void dispose() {
    demandaController.finalize();
    super.dispose();
  }

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
            child: BlocConsumer<DemandaBloc, DemandaState>(
              listener: (context, state) {
                switch (state) {
                  case DemandaCreateState():
                    showBlocSnackbar(context, "Bolo adicionado com sucesso");
                  case DemandaDeleteState():
                    showBlocSnackbar(context, "Bolo removido com sucesso!");
                  case DemandaUpdateState():
                    showBlocSnackbar(context, "Bolo atualizado com sucesso!");
                  case DemandaLoadingState():
                    break;
                  case DemandaLoadedState():
                    break;
                  case DemandaFilterState():
                    break;
                  case DemandaFetchState():
                    break;
                  case DemandaErrorState():
                    showBlocSnackbar(context, state.message);
                }
              },
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
                    String? imageUrl;
                    if (demanda['produto_id'] != null) {
                      imageUrl = context
                          .read<ProdutoBloc>()
                          .getImageUrl(demanda['produto_id']);
                    }
                    return DemandCard(
                      nomeDemanda:
                          demanda['nome_demanda'] ?? 'Nome não disponível',
                      status: demanda['status'] ?? 'Status não disponível',
                      statusAplique: demanda['status_aplique'] ?? 1,
                      statusCobertura: demanda['status_cobertura'] ?? 1,
                      statusMontagem: demanda['status_montagem'] ?? 1,
                      codigo: demanda['produto_id'] ?? 'Sem código',
                      descricao: demanda['descricao'] ?? 'Sem descrição',
                      dataAdicao: demanda['data_adicao'],
                      prazo: demanda['prazo'] ?? demanda['data_adicao'],
                      id: demanda['id'],
                      imagemUrl: imageUrl ?? '',
                      order: index,
                      plataforma: demanda['loja'] ?? 'Sem plataforma',
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.189,
      height: size.height * 0.047,
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
          key: Key('adicionarDemandaButton'),
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
              fontFamily: "Fredoka",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addInfoDemand(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          final size = MediaQuery.of(context).size;

          final TextEditingController nomeController = TextEditingController();
          final TextEditingController codigoController =
              TextEditingController();
          final TextEditingController descricaoController =
              TextEditingController();
          final TextEditingController dataController = TextEditingController();
          final TextEditingController prazoController = TextEditingController();
          final TextEditingController lojaController = TextEditingController();
          return ReusableDialog(
            backgroundColor: AppColors.lightGray,
            title: "Adicionar Demanda",
            confirmBeforeClose: true,
            body: SingleChildScrollView(
              key: Key('addDemandScrollView'),
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
                              size: size.width * 0.02,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Informações Gerais",
                              style: TextStyle(
                                fontSize: size.height * 0.016,
                                fontFamily: 'FredokaOne',
                                color: AppColors.gradientDarkBlue,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: size.height * 0.022),
                              child: Text(
                                "Código",
                                style: TextStyle(
                                    color: AppColors.gradientDarkBlue,
                                    fontSize: size.height * 0.016,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Expanded(
                              child: InputTextField(
                                key: Key('codigoDemandaInput'),
                                labelText: "",
                                hintText: "Código da demanda",
                                controller: codigoController,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: size.height * 0.022),
                              child: Text(
                                "Nome",
                                style: TextStyle(
                                    color: AppColors.gradientDarkBlue,
                                    fontSize: size.height * 0.016,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            Expanded(
                              child: InputTextField(
                                key: Key('nomeDemandaInput'),
                                hintText: "Nome da demanda",
                                controller: nomeController,
                                labelText: '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Loja*",
                              style: TextStyle(
                                  color: AppColors.gradientDarkBlue,
                                  fontSize: size.height * 0.016,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Dropdownbutton(
                              controller: lojaController,
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
                                  fontSize: size.height * 0.016,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              key: Key('dataPedidoInput'),
                              child: inputDate(dataController),
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
                                  fontSize: size.height * 0.016,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              key: Key('prazoInput'),
                              child: inputDate(prazoController),
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
                              size: size.width * 0.02,
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
                          key: Key('descricaoDemandaInput'),
                          labelText: "Descrição",
                          hintText: "Digite a descrição",
                          controller: descricaoController,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    key: Key('concluirButton'),
                    onPressed: () async {
                      if (codigoController.text.isNotEmpty ||
                          nomeController.text.isNotEmpty) {
                        bloc.add(DemandaCreate(
                          nomeDemanda: nomeController.text,
                          codigo: codigoController.text,
                          descricao: descricaoController.text,
                          loja: lojaController.text,
                          data: dataController.text,
                          prazo: prazoController.text,
                        ));
                        Navigator.pop(context);
                      } else {
                        showBlocSnackbar(
                          context,
                          "Por favor, preencha pelo menos o código ou nome do bolo",
                          postFrameCallBack: false,
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
