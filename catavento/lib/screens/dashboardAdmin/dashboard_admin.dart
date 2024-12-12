import 'dart:io';

import 'package:catavento/bloc/demanda_bloc.dart';
import 'package:catavento/bloc/demanda_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:catavento/screens/dashboardAdmin/components/stage_demand.dart';
import 'package:catavento/screens/dashboardAdmin/components/menu.dart';
import '../../services/table_import/table_import.dart';
import '../../services/table_import/table_picker.dart';
import '../dashboardAdmin/components/confirmDialog.dart';

import 'package:image_picker/image_picker.dart';

class DashBoardAdmin extends StatelessWidget {
  const DashBoardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF015C98),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 20), // Padding aqui
              child: Material(
                color: Colors.transparent, // Mantém o fundo transparente
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer(); // Abre o Drawer
                  },
                  child: const Icon(
                    Icons.menu,
                    size: 40.0,
                    color: Color(0xFF015C98),
                  ),
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 20), // Ajuste o valor conforme necessário
            child: TextButton.icon(
              icon: const Icon(Icons.history, size: 18.0),
              label: const Text("Ver Histórico"),
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF015C98),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
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
                style: TextStyle(fontSize: 29.5, color: Color(0xFF015C98)),
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

//Icon Menu
class IconMenu extends StatefulWidget {
  const IconMenu({super.key});

  @override
  State<IconMenu> createState() {
    return IconMenuState();
  }
}

//Icon Menu
class IconMenuState extends State<IconMenu> {
  @override
  Widget build(BuildContext context) {
    //Icon Menu
    return Positioned(
      top: 20,
      left: 20,
      child: IconButton(
        iconSize: 50,
        onPressed: () {
          //Logica do menu
        },
        icon: Icon(Icons.menu),
        color: Color(0xFF015C98),
      ),
    );
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
      buildWhen: (previous, current) => current is! DemandaFilterState,
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
                    bloc: context.read<DemandaBloc>(),
                  );
                },
              );
            },
          )),
          SizedBox(height: 16), // Espaço entre a lista e o botão
          ButtonAddDemanda(
            bloc: context.read<DemandaBloc>(),
          ),
        ],
      ),
    );
  }
}

class ButtonAddDemanda extends StatelessWidget {
  final DemandaBloc bloc;
  ButtonAddDemanda({
    super.key,
    required this.bloc,
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
          AddInfoDemand(context);
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

  Future<void> AddInfoDemand(BuildContext context) => showGeneralDialog(
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: AlertDialog(
              backgroundColor: Color(0xFFD1EEFF),
              content: SizedBox(
                height: 446,
                width: 534,
                child: Padding(
                  padding: const EdgeInsets.only(top: 41),
                  child: Column(
                    children: [
                      // campo dos formulários
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Nova demanda",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 47,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Código",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  TextField(
                                    controller: _codigoController,
                                    decoration: InputDecoration(
                                      hintText: "Código da demanda",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nome",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  TextField(
                                    controller: _nomeController,
                                    decoration: InputDecoration(
                                      hintText: "Nome da demanda",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 47,
                      ),
                      // campo de descricao
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Descrição",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: _descricaoController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      // Botão para selecionar foto
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _selecionarFoto(context);
                              },
                              child: Text("Selecionar Foto"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                              SnackBar(
                                  content: Text(
                                      "Por favor, preencha todos os campos")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF015C98),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22))),
                        child: Text(
                          "Cadastrar demanda",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}

class ButtonConcluir extends StatelessWidget {
  const ButtonConcluir({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 169,
        height: 33,
        child: ElevatedButton(
            onPressed: () {
              //Lógica do botão
              showDialogConfirm(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF50B432),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27))),
            child: Text(
              "Concluir",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            )),
      ),
    );
  }
}

void showDialogConfirm(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Deseja confirmar a operação?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Essa operação não poderá ser revertida",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 137,
                  height: 57,
                  child: ElevatedButton(
                      onPressed: () {
                        //Lógica do botão
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF50B432),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22))),
                      child: Text(
                        "Sim",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )),
                ),
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 137,
                  height: 57,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFD54A3D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22))),
                      child: Text(
                        "Não",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            )),
          ],
        );
      });
}

//Botão de escolha prioridade
class ButtonChoosePriority extends StatefulWidget {
  const ButtonChoosePriority({super.key});

  @override
  State<ButtonChoosePriority> createState() {
    return ButtonChoosePriorityState();
  }
}

class ButtonChoosePriorityState extends State<ButtonChoosePriority> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146,
      height: 25,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(9),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(
          "Escolha uma opção",
          style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5)),
        ),
        underline: SizedBox(),
        value: selectedOption,
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue;
          });
        },
        items: ["Alta", "Média", "Baixa"].map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
      ),
    );
  }
}

//input do nome e do id
Widget inputNameID() {
  return SizedBox(
    width: 143,
    height: 24,
    //input do código
    child: TextField(
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey, width: 2))),
    ),
  );
}

//input das datas
Widget inputDate() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 95,
        height: 25,
        //input da data
        child: TextField(
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          decoration: InputDecoration(
              hintText: 'dd/mm/yy',
              hintStyle:
                  TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 2))),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.calendar_month,
        color: Colors.black26,
      )
    ],
  );
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  final TextEditingController _nomeDemanda = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 499,
      height: 32,
      child: TextField(
        controller: _nomeDemanda,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFF015C98),
            ),
            //Icon de pesquisa

            hintText: "Insira o nome de uma demanda para iniciar uma busca",
            hintStyle: TextStyle(
                fontSize: 11,
                color: Colors.black.withOpacity(0.5) //Opacidade do texto
                ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(16),
            )),
        onEditingComplete: () {
          context.read<DemandaBloc>().add(DemandaFilter(
                'nomeDemanda',
                _nomeDemanda.text,
              ));
        },
      ),
    );
  }
}

class QuadroPrioridade extends StatefulWidget {
  const QuadroPrioridade({super.key});

  @override
  State<QuadroPrioridade> createState() {
    return QuadroPrioridadeState();
  }
}

class QuadroPrioridadeState extends State<QuadroPrioridade> {
  Color colorQ = Color(0xFFC3206F);

  //Troca a cor do quadro
  void prioridadeAlta() {
    setState(() {
      colorQ = Color(0xFFC3206F);
    });
  }

  //Troca a cor do quadro
  void prioridadeMedia() {
    setState(() {
      colorQ = Color(0xFFFF66B0);
    });
  }

  //Troca a cor do quadro
  void prioridadeBaixa() {
    setState(() {
      colorQ = Color(0xFFFFC6E1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Quadro de prioridade
        Container(
          width: 340,
          height: 398,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: colorQ),
        ),

        SizedBox(
          height: 15,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Botão alta prioridade
            SizedBox(
              width: 97,
              height: 24,
              child: ElevatedButton(
                onPressed: prioridadeAlta,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC3206F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Alta',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 17,
            ),

            //Botão média prioridade
            SizedBox(
              width: 97,
              height: 24,
              child: ElevatedButton(
                onPressed: prioridadeMedia,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF66B0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Média',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 17,
            ),

            //Botão baixa prioridade
            SizedBox(
              width: 97,
              height: 24,
              child: ElevatedButton(
                onPressed: prioridadeBaixa,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC6E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Baixa',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

// Dialog
void _showCustomDialog(
    BuildContext context,
    String name,
    String code,
    DateTime createdAt,
    DateTime updatedAt,
    String description,
    String imageCake) {
  String createdAtFormat = DateFormat('dd/MM/yyyy').format(createdAt);
  String updatedAtFormat = DateFormat('dd/MM/yyyy').format(updatedAt);

  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          backgroundColor: Color(0xFFD1EEFF),
          content: SizedBox(
              width: 560,
              child: Padding(
                padding: const EdgeInsets.only(top: 41),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                              child: Align(
                            //Aqui ficará o nome da demanda ou qual demanda será
                            alignment: Alignment.center,
                            child: Text("Nome da demanda ${name}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )),
                          )),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                size: 25,
                              ))
                        ],
                      ),
                      SizedBox(height: 31),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 186,
                            height: 202,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(imageCake))),
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: "Código: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      children: [TextSpan(text: "${code}")])),
                              SizedBox(height: 10),
                              RichText(
                                  text: TextSpan(
                                      text: "Data do pedido: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      children: [
                                    TextSpan(text: "${createdAtFormat}")
                                  ])),
                              SizedBox(height: 10),
                              RichText(
                                  text: TextSpan(
                                      text: "Prazo: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      children: [
                                    TextSpan(text: "${updatedAtFormat}")
                                  ])),
                              SizedBox(height: 10),
                              RichText(
                                  text: TextSpan(
                                      text: "Descrição: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      children: [
                                    TextSpan(text: "${description}")
                                  ])),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Acompanhamento da produção",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Status: Em andamento",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StageDemand(status: "finished"),
                      SizedBox(
                        height: 20,
                      ),
                      StageDemand(status: "InProgress"),
                      SizedBox(
                        height: 20,
                      ),
                      StageDemand(status: "Erro"),
                    ],
                  ),
                ),
              )),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide.none),
        ),
      );
    },
  );
}

class DemandCard extends StatelessWidget {
  final String nomeDemanda;
  final String status;
  final String codigo;
  final String descricao;
  final int id;
  final String imagemUrl;
  final int order;
  final DemandaBloc bloc;

  const DemandCard({
    super.key,
    required this.nomeDemanda,
    required this.codigo,
    required this.status,
    required this.descricao,
    required this.id,
    required this.order,
    required this.imagemUrl,
    required this.bloc, // Função de atualização
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nomeController =
        TextEditingController(text: nomeDemanda);
    final TextEditingController _codigoController =
        TextEditingController(text: codigo);
    final TextEditingController _descricaoController =
        TextEditingController(text: descricao);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(nomeDemanda),
        subtitle: Text(
            'Código: ${codigo.isNotEmpty ? codigo : 'Sem código'}\nStatus: $status'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagemUrl.isNotEmpty
                ? Image.network(imagemUrl, width: 50, height: 50)
                : Icon(Icons.image, size: 50),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                _showInfoDialog(
                    context, nomeDemanda, codigo, descricao, status);
              },
            ),
            // botão de Editar.
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                //  editar a demanda
                _showEditDialog(context, _nomeController, _codigoController,
                    _descricaoController, bloc);
              },
            ),
            // apagar
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmDialog(
                        title: 'Confirmar Exclusão',
                        contente:
                            'Tem certeza de que deseja apagar esta demanda?',
                        onConfirm: () {
                          Navigator.of(context).pop(); // Fecha o diálogo
                          bloc.add(
                              DemandaDelete(id, order)); // Executa a exclusão
                        },
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  // Função para mostrar as informações da demanda em um diálogo
  void _showInfoDialog(BuildContext context, String nome, String codigo,
      String descricao, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Informações da Demanda"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nome: $nome",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Código: $codigo",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Status: $status",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Descrição: $descricao",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  // Função que exibe o diálogo de edição
  void _showEditDialog(
      BuildContext context,
      TextEditingController nomeController,
      TextEditingController codigoController,
      TextEditingController descricaoController,
      DemandaBloc bloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar Demanda"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: "Nome da Demanda"),
                ),
                TextField(
                  controller: codigoController,
                  decoration: InputDecoration(labelText: "Código da Demanda"),
                ),
                TextField(
                  controller: descricaoController,
                  decoration:
                      InputDecoration(labelText: "Descrição da Demanda"),
                  maxLines: null, // Permite múltiplas linhas
                  minLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Atualizar a demanda no Supabase
                bloc.add(DemandaUpdate(
                  id,
                  order,
                  nomeController.text,
                  codigoController.text,
                  descricaoController.text,
                ));
                //_updateDemanda(nomeController.text, codigoController.text,descricaoController.text);
                Navigator.pop(context); // Fechar o diálogo
              },
              child: Text("Salvar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fechar o diálogo sem salvar
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}

Widget _buildActionButton({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return Row(
    children: [
      IconButton(
        icon: Icon(icon),
        iconSize: 18,
        onPressed: onPressed,
      ),
      SizedBox(width: 5),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    ],
  );
}

// EDITAR DEMANDA
// O parâmetro 'context' informa onde o widget será inserido na árvore de widgets.
void editarDemanda(BuildContext context) {
  showGeneralDialog(
    context:
        context, // Indica onde o diálogo será exibido na árvore de widgets.
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          backgroundColor: Color(0xFFD1EEFF),
          content: SizedBox(
            height: 446,
            width: 534,
            child: Padding(
              padding: const EdgeInsets.only(top: 41),
              child: Column(
                children: [
                  // Título do diálogo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Editar demanda",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 25,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // Campos de código
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Código",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      inputNameID(),
                      SizedBox(width: 50),
                    ],
                  ),

                  SizedBox(height: 14),

                  // Campos de data do pedido e prazo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Data do pedido",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      inputDate(),
                      SizedBox(width: 54),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Prazo",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      inputDate(),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Descrição
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 70),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Descrição",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 339,
                        height: 92,
                        child: TextField(
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          maxLines: null,
                          minLines: 6,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 15),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 23),

                  // Prioridade
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Prioridade",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ButtonChoosePriority(),
                    ],
                  ),

                  SizedBox(height: 47),

                  // Botão de Concluir
                  ButtonConcluir(),
                ],
              ),
            ),
          ),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
        ),
      );
    },
  );
}
