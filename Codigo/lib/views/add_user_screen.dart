import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/stores/add_user_store.dart';
import 'package:sglh/views/components/utils/error_box.dart';
import 'package:sglh/views/components/utils/select_form.dart';
import 'package:sglh/views/components/utils/styles.dart';

import 'components/utils/image_source_modal.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final AddUserStore addUserStore = AddUserStore();

  final List<ReactionDisposer> _disposers = [];

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(
      autorun(
        (_) {
          if (addUserStore.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(addUserStore.error!),
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 4),
            ));
          }
        },
      ),
    );
    _disposers.add(
      reaction(
        (_) => addUserStore.userCreated,
        (_) => Navigator.of(context).pop(),
      ),
    );

    _disposers.add(
      reaction(
        (_) => addUserStore.userCreated,
        (_) => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File photo) {
      print(photo);
      addUserStore.setPhoto(photo);
      Navigator.of(context).pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Usuário"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Observer(builder: (_) {
              if (addUserStore.isLoading) {
                return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: const [
                        Text(
                          'Salvando Usuário...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    ));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          if (Platform.isAndroid) {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceModal(
                                onImageSelected: onImageSelected,
                              ),
                            );
                          } else {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceModal(
                                onImageSelected: onImageSelected,
                              ),
                            );
                          }
                        },
                        child: addUserStore.photo == null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[400],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.person_pin,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            : CircleAvatar(
                                radius: 80,
                                backgroundImage: FileImage(addUserStore.photo),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Observer(builder: (_) {
                        return TextFormField(
                          initialValue: addUserStore.name,
                          style: getFormTextStyle(),
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          onChanged: addUserStore.setName,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: getContentPadding(),
                            labelText: "Nome *",
                            labelStyle: getTextLabelStyle(),
                            errorText: addUserStore.nameError,
                          ),
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Observer(builder: (_) {
                        return TextFormField(
                          initialValue: addUserStore.email,
                          style: getFormTextStyle(),
                          textInputAction: TextInputAction.next,
                          onChanged: addUserStore.setEmail,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: getContentPadding(),
                            labelText: "E-mail *",
                            labelStyle: getTextLabelStyle(),
                            errorText: addUserStore.emailError,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Observer(
                        builder: (_) => AppDropdownInput<String>(
                          hintText: "Cargo *",
                          options: addUserStore.roles,
                          value: addUserStore.post,
                          onChanged: addUserStore.setPost,
                          getLabel: (String value) => value,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              labelText: "Data *",
                              labelStyle: getTextLabelStyle(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                            isEmpty: false,
                            child: InkWell(
                              child: Builder(builder: (context) {
                                return OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.all(0),
                                    side: BorderSide.none,
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: addUserStore.startDate,
                                      firstDate: DateTime(2015, 8),
                                      lastDate: DateTime(2101),
                                      cancelText: 'Cancelar',
                                      confirmText: 'Selecionar',
                                    );
                                    if (picked != null) {
                                      addUserStore.setStartDate(picked);
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Observer(builder: (_) {
                                        return Text(
                                          DateFormat('dd/MM/yyyy')
                                              .format(addUserStore.startDate),
                                          style: getFormTextStyle(),
                                        );
                                      }),
                                      const Icon(
                                        Icons.calendar_month,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                    Observer(builder: (_) {
                      return ErrorBox(
                        message: addUserStore.error,
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Observer(
                        builder: (_) => AppDropdownInput<String>(
                          hintText: "Tipo de Usuário *",
                          options: const ['Administrador', 'Comum'],
                          value: addUserStore.userTypeString ?? 'Comum',
                          onChanged: addUserStore.setUserType,
                          getLabel: (String value) => value,
                        ),
                      ),
                    ),
                    Padding(
                      padding: getContentPadding(),
                      child: SizedBox(
                        height: 50,
                        child: Observer(
                          builder: (_) => GestureDetector(
                            onTap: () {},
                            child: ElevatedButton(
                              onPressed: addUserStore.signupPressed,
                              child: Text(
                                'Finalizar Cadastro',
                                style: addUserStore.isFormValid
                                    ? getFormTextStyle()
                                    : getFormTextStyle()
                                        .copyWith(color: Colors.grey),
                              ),
                              style: ButtonStyle(
                                enableFeedback: !addUserStore.isFormValid,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: MaterialStateProperty.resolveWith(
                                  (_) => RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor: addUserStore.isFormValid
                                    ? MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 109, 209, 218),
                                      )
                                    : MaterialStateProperty.all(
                                        const Color.fromARGB(255, 116, 64, 43)
                                            .withAlpha(800),
                                      ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
