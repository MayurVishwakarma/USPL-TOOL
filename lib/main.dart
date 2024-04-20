import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uspltool/Provider/DashbordProvider.dart';
import 'package:uspltool/Provider/TradeBookProvider.dart';
import 'package:uspltool/Provider/trade_provider.dart';
import 'package:uspltool/Routes/router.dart';
import 'package:uspltool/utils/theme_manager.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();  
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => TradeProvider()),
        ChangeNotifierProvider(create: (context) => TradeBookProvider()),
      ],
      child: MaterialApp(
        title: 'MOTA-TOOL',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        theme: ThemeManager().lightThemeData.copyWith(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      ),
    );
  }
}
