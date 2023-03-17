// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'home_page_model.dart';
// export 'home_page_model.dart';

// class HomePageWidget extends StatefulWidget {
//   const HomePageWidget({Key? key}) : super(key: key);

//   @override
//   _HomePageWidgetState createState() => _HomePageWidgetState();
// }

// class _HomePageWidgetState extends State<HomePageWidget> {
//   late HomePageModel _model;

//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _unfocusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => HomePageModel());
//   }

//   @override
//   void dispose() {
//     _model.dispose();

//     _unfocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
//           child: ListView(
//             padding: EdgeInsets.zero,
//             scrollDirection: Axis.vertical,
//             children: [
//               Stack(
//                 children: [
//                   Align(
//                     alignment: AlignmentDirectional(-0.04, 0),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
//                       child: Container(
//                         width: 350,
//                         height: 29,
//                         decoration: BoxDecoration(
//                           color: Color(0xFFFF8F8F),
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(0),
//                             bottomRight: Radius.circular(0),
//                             topLeft: Radius.circular(5),
//                             topRight: Radius.circular(5),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                               child: Text(
//                                 'Inductions',
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       fontSize: 1,
//                                         2,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 30, 0),
//                               child: Text(
//                                 '21h',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Align(
//                     alignment: AlignmentDirectional(-0.04, 0),
//                     child: Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(0, 45, 0, 0),
//                       child: Container(
//                         width: 350,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [Color(0xEFEF2828), Color(0x86FF0007)],
//                             stops: [0, 1],
//                             begin: AlignmentDirectional(0, -1),
//                             end: AlignmentDirectional(0, 1),
//                           ),
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(0),
//                             bottomRight: Radius.circular(0),
//                             topLeft: Radius.circular(5),
//                             topRight: Radius.circular(5),
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
//                               child: Text(
//                                 'Townhall at AC02 5ht floor  about Food and mess',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsetsDirectional.fromSTEB(
//                                   20, 10, 20, 10),
//                               child: Text(
//                                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec non volutpat diam. Nunc nec rutrum elit. Nulla eu venenatis',
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .bodyText1
//                                     .override(
//                                       fontFamily: 'Poppins',
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.normal,
//                                     ),
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
//                               child: InkWell(
//                                 onTap: () async {
//                                   context.pushNamed('HomePage');
//                                 },
//                                 child: Text(
//                                   'Read More',
//                                   style: FlutterFlowTheme.of(context)
//                                       .bodyText1
//                                       .override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.white,
//                                         fontSize: 10,
//                                       ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
