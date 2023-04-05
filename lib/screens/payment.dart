import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/custom_button.dart';
import 'package:ash_app/widget/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';
import 'package:ash_app/utils/utils.dart';

class KhaltiPayment extends StatefulWidget {
  const KhaltiPayment({Key? key}) : super(key: key);

  @override
  State<KhaltiPayment> createState() => _KhaltiPaymentState();
}

class _KhaltiPaymentState extends State<KhaltiPayment> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppMainTheme.primaryColor),
          title: const Text(
            'Payment',
            style: TextStyle(
              fontSize: 23,
              color: AppMainTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomTextFormField(
                hint: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                hint: 'Pin Code',
                obscureText: true,
                controller: pinCodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () async {
                  if (phoneController.text.isEmpty) {
                    customGetSnackbar(
                        'Error', 'Phone number is required', 'error');
                    return;
                  }
                  if (pinCodeController.text.isEmpty) {
                    customGetSnackbar('Error', 'Pin code is required', 'error');
                    return;
                  }
                  try {
                    final initiationModel =
                        await Khalti.service.initiatePayment(
                      request: PaymentInitiationRequestModel(
                        amount: 1000,
                        mobile: phoneController.text,
                        productIdentity: 'PID-12',
                        productName: 'Product Name',
                        transactionPin: pinCodeController.text,
                        productUrl: '',
                        additionalData: {},
                      ),
                    );

                    final otp = await showDialog(
                        context: (context),
                        barrierDismissible: false,
                        builder: (context) {
                          String? opt;
                          return AlertDialog(
                            title: const Text('Enter OTP'),
                            content: TextField(
                              onChanged: (v) => opt = v,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text('OTP'),
                              ),
                            ),
                            actions: [
                              SimpleDialogOption(
                                  child: const Text('Submit'),
                                  onPressed: () {
                                    Navigator.pop(context, opt);
                                  })
                            ],
                          );
                        });

                    if (otp != null) {
                      try {
                        final model = await Khalti.service.confirmPayment(
                          request: PaymentConfirmationRequestModel(
                            confirmationCode: otp,
                            token: initiationModel.token,
                            transactionPin: pinCodeController.text,
                          ),
                        );

                        Navigator.pop(context, model.token);
                      } catch (e) {
                        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                title: 'Make Payment',
              ),
            ],
          ),
        ));
  }
}
