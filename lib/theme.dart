import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278217321),
      surfaceTint: Color(4278217321),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288475632),
      onPrimaryContainer: Color(4278198304),
      secondary: Color(4283065186),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291619047),
      onSecondaryContainer: Color(4278525727),
      tertiary: Color(4283129980),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4292076799),
      onTertiaryContainer: Color(4278459445),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294245370),
      onSurface: Color(4279639325),
      onSurfaceVariant: Color(4282337608),
      outline: Color(4285495672),
      outlineVariant: Color(4290693576),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020977),
      inversePrimary: Color(4286633427),
      primaryFixed: Color(4288475632),
      onPrimaryFixed: Color(4278198304),
      primaryFixedDim: Color(4286633427),
      onPrimaryFixedVariant: Color(4278210639),
      secondaryFixed: Color(4291619047),
      onSecondaryFixed: Color(4278525727),
      secondaryFixedDim: Color(4289776843),
      onSecondaryFixedVariant: Color(4281486155),
      tertiaryFixed: Color(4292076799),
      onTertiaryFixed: Color(4278459445),
      tertiaryFixedDim: Color(4289906920),
      onTertiaryFixedVariant: Color(4281550947),
      surfaceDim: Color(4292205530),
      surfaceBright: Color(4294245370),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916148),
      surfaceContainer: Color(4293521390),
      surfaceContainerHigh: Color(4293126632),
      surfaceContainerHighest: Color(4292732131),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278209355),
      surfaceTint: Color(4278217321),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280516992),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281222983),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284447097),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281287775),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284577427),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294245370),
      onSurface: Color(4279639325),
      onSurfaceVariant: Color(4282074436),
      outline: Color(4283916640),
      outlineVariant: Color(4285758844),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020977),
      inversePrimary: Color(4286633427),
      primaryFixed: Color(4280516992),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278216550),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284447097),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282868064),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284577427),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282932601),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205530),
      surfaceBright: Color(4294245370),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916148),
      surfaceContainer: Color(4293521390),
      surfaceContainerHigh: Color(4293126632),
      surfaceContainerHighest: Color(4292732131),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278200103),
      surfaceTint: Color(4278217321),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278209355),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278986278),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281222983),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278919996),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4281287775),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294245370),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280034853),
      outline: Color(4282074436),
      outlineVariant: Color(4282074436),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020977),
      inversePrimary: Color(4289133561),
      primaryFixed: Color(4278209355),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278203187),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281222983),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279710000),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4281287775),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4279774791),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205530),
      surfaceBright: Color(4294245370),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916148),
      surfaceContainer: Color(4293521390),
      surfaceContainerHigh: Color(4293126632),
      surfaceContainerHighest: Color(4292732131),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4286633427),
      surfaceTint: Color(4286633427),
      onPrimary: Color(4278204215),
      primaryContainer: Color(4278210639),
      onPrimaryContainer: Color(4288475632),
      secondary: Color(4289776843),
      onSecondary: Color(4279973172),
      secondaryContainer: Color(4281486155),
      onSecondaryContainer: Color(4291619047),
      tertiary: Color(4289906920),
      onTertiary: Color(4280037707),
      tertiaryContainer: Color(4281550947),
      onTertiaryContainer: Color(4292076799),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279112980),
      onSurface: Color(4292732131),
      onSurfaceVariant: Color(4290693576),
      outline: Color(4287140754),
      outlineVariant: Color(4282337608),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292732131),
      inversePrimary: Color(4278217321),
      primaryFixed: Color(4288475632),
      onPrimaryFixed: Color(4278198304),
      primaryFixedDim: Color(4286633427),
      onPrimaryFixedVariant: Color(4278210639),
      secondaryFixed: Color(4291619047),
      onSecondaryFixed: Color(4278525727),
      secondaryFixedDim: Color(4289776843),
      onSecondaryFixedVariant: Color(4281486155),
      tertiaryFixed: Color(4292076799),
      onTertiaryFixed: Color(4278459445),
      tertiaryFixedDim: Color(4289906920),
      onTertiaryFixedVariant: Color(4281550947),
      surfaceDim: Color(4279112980),
      surfaceBright: Color(4281612858),
      surfaceContainerLowest: Color(4278783759),
      surfaceContainerLow: Color(4279639325),
      surfaceContainer: Color(4279902497),
      surfaceContainerHigh: Color(4280625963),
      surfaceContainerHighest: Color(4281284150),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4286896600),
      surfaceTint: Color(4286633427),
      onPrimary: Color(4278196762),
      primaryContainer: Color(4282883741),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290105551),
      onSecondary: Color(4278196762),
      secondaryContainer: Color(4286289557),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4290235629),
      onTertiary: Color(4278196015),
      tertiaryContainer: Color(4286419632),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112980),
      onSurface: Color(4294376699),
      onSurfaceVariant: Color(4290956748),
      outline: Color(4288390564),
      outlineVariant: Color(4286285188),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292732131),
      inversePrimary: Color(4278210896),
      primaryFixed: Color(4288475632),
      onPrimaryFixed: Color(4278195220),
      primaryFixedDim: Color(4286633427),
      onPrimaryFixedVariant: Color(4278205757),
      secondaryFixed: Color(4291619047),
      onSecondaryFixed: Color(4278195220),
      secondaryFixedDim: Color(4289776843),
      onSecondaryFixedVariant: Color(4280367674),
      tertiaryFixed: Color(4292076799),
      onTertiaryFixed: Color(4278194726),
      tertiaryFixedDim: Color(4289906920),
      onTertiaryFixedVariant: Color(4280432465),
      surfaceDim: Color(4279112980),
      surfaceBright: Color(4281612858),
      surfaceContainerLowest: Color(4278783759),
      surfaceContainerLow: Color(4279639325),
      surfaceContainer: Color(4279902497),
      surfaceContainerHigh: Color(4280625963),
      surfaceContainerHighest: Color(4281284150),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4293591038),
      surfaceTint: Color(4286633427),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4286896600),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293591038),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290105551),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294638335),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4290235629),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112980),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294180348),
      outline: Color(4290956748),
      outlineVariant: Color(4290956748),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292732131),
      inversePrimary: Color(4278202416),
      primaryFixed: Color(4288738804),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4286896600),
      onPrimaryFixedVariant: Color(4278196762),
      secondaryFixed: Color(4291882219),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290105551),
      onSecondaryFixedVariant: Color(4278196762),
      tertiaryFixed: Color(4292536575),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4290235629),
      onTertiaryFixedVariant: Color(4278196015),
      surfaceDim: Color(4279112980),
      surfaceBright: Color(4281612858),
      surfaceContainerLowest: Color(4278783759),
      surfaceContainerLow: Color(4279639325),
      surfaceContainer: Color(4279902497),
      surfaceContainerHigh: Color(4280625963),
      surfaceContainerHighest: Color(4281284150),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
