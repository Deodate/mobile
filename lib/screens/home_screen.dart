

import 'package:first_quiz/contants/colors.dart';
import 'package:first_quiz/provider/cal_provider.dart';
import 'package:first_quiz/screens/widgets_data.dart';
import 'package:first_quiz/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cal_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    const padding = EdgeInsets.symmetric(horizontal: 25, vertical: 30);
    const decoration = BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)));

    return Consumer<CalculatorProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("CALCULATOR"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            CustomTextField(
              controller: provider.compController,
            ),
            const Spacer(),
            Container(
              height: screenHeight * 0.6,
              width: double.infinity,
              padding: padding,
              decoration: decoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) => buttonList[index]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(4, (index) => buttonList[index + 4]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(4, (index) => buttonList[index + 8]),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  3, (index) => buttonList[index + 12]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  3, (index) => buttonList[index + 15]),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const CalculateButton()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}









// import 'package:first_quiz/contants/colors.dart';
// import 'package:first_quiz/screens/widgets_data.dart';
// import 'package:first_quiz/widgets/textfield.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     final padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 30);
//     final decoration = BoxDecoration(
//       color: AppColors.secondaryColor,
//       borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
//     );

//     return Scaffold(
//       backgroundColor: const Color(0xFF4070F4), 
//       appBar: AppBar(
//         title: const Text(
//           "CALCULATOR",
//           style: TextStyle(color: Colors.white), 
//         ),
//         backgroundColor: const Color(0xFF4070F4), 
//       body: Column(
//         children: [
//           const CustomTextField(),
//           Expanded(
//             child: Container(
//               padding: padding,
//               decoration: decoration,
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 1.0,
//                 ),
//                 itemCount: buttonList.length + 1, 
//                 itemBuilder: (context, index) {
//                   if (index == buttonList.length) {
                  
//                     return SizedBox(
//                       width: double.infinity, 
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
                       
//                       ),
//                     );
//                   }
//                   return buttonList[index];
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
