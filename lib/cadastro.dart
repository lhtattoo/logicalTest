import 'package:flutter/material.dart';
import 'package:logicaltest/register/model/register_model.dart';
import 'package:logicaltest/validation.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final Validation validar = Validation();
  final _formKey = GlobalKey<FormState>();
  final RegisterModel usuario = RegisterModel();
  final nameEC = TextEditingController();
  final sobrenomeEC = TextEditingController();
  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    emailEC.dispose();
    senhaEC.dispose();
    sobrenomeEC.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Página de Cadastro'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
                key: this._formKey,
                child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameEC,
                          decoration: InputDecoration(
                            label: Text('Nome'),
                            hintText: 'Digite nome completo',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                          validator: (nome) =>
                              validar.campoNome(nome.toString()),
                          onSaved: (String? value) {
                            usuario.nome = value;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: sobrenomeEC,
                          autofocus: true,
                          decoration: InputDecoration(
                            label: Text('Sobrenome'),
                            hintText: 'Digite sobrenome',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                          validator: (sobrenome) =>
                              validar.campoSobreNome(sobrenome.toString()),
                          onSaved: (String? value) {
                            usuario.sobrenome = value;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: emailEC,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'nome@email.com',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (emailEC) {
                            //Validator
                          },
                          validator: (email) =>
                              validar.campoEmail(email.toString()),
                          onSaved: (String? value) {
                            usuario.email = value;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: senhaEC,
                          autofocus: true,
                          decoration: InputDecoration(
                            label: Text('Senha'),
                            hintText: 'Digite sua senha',
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                          validator: (senha) =>
                              validar.campoSenha(senha.toString()),
                          onSaved: (String? value) {
                            usuario.senha = value;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            child: Text('Cadastrar'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              _onSubmit(context);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            child: Text('Sair do cadastro'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),

                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            //child: Text('Sair do Cadastro'),
                          ),
                        )
                      ],
                    )))));
  }

  void _onSubmit(inContext) {
    if (_formKey.currentState!.validate()) {
      print('Formulário Validado!');
      // Salva os dados preenchido no formulário através
      // das propriedades onSaved de cada campo do formulário
      _formKey.currentState!.save();
      // chama a rota nomeada enviando enviando os dados do usuário
      // só que agora os dados do usuário são enviados
      // como argumentos da rota
      Navigator.of(inContext).pushNamed('/pagina_dados', arguments: usuario);
      // Navigator.of(inContext)
      //     .pushNamed(Routes.PAGINA_DADOS, arguments: usuario);
    } else {
      print('********* Formulário com erros. ********');
      showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (inContext) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Dados Inválidos!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(inContext);
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(inContext);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
