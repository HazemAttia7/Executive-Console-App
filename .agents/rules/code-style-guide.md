---
trigger: always_on
---

# Coding Style Guide

## Core Rule

Write new code in the **same style, structure, patterns, and conventions used in the existing codebase**.

The existing codebase is the primary source of truth.

Before creating or modifying code:

* Inspect similar existing files first.
* Follow the existing folder structure.
* Follow existing naming conventions.
* Follow existing implementation patterns.
* Reuse existing widgets, Cubits, controllers, repositories, utilities, styles, and helpers.
* Do not introduce a new architecture, abstraction, package, or pattern unless explicitly requested.
* Do not refactor unrelated code.
* Do not replace an existing project pattern with generic "best practices" if the existing pattern already works.

The goal is for generated code to look like it was written by the existing developer.

---

# Architecture

Follow the project's existing **MVVM architecture**.

The project uses:

* MVVM for separation of UI and presentation logic.
* Cubit/BLoC for business logic and feature state.
* ChangeNotifier controllers for view-related logic.
* Repository Pattern for data access.
* GetIt for dependency injection.
* Provider for controller management.

Do not replace these with another architecture or state-management solution unless explicitly requested.

### Responsibilities

* **Views/Widgets:** UI and user interaction only.
* **Controllers/ViewModels:** view-related state and presentation logic.
* **Cubits:** feature business logic and state management when the feature uses Cubit.
* **Repositories:** data access and coordination.
* Keep responsibilities separated.
* Do not put business logic directly inside widgets.
* Do not put UI logic inside repositories.

When implementing a feature, find the closest existing feature and mirror its structure.

---

# State Management

Use the state-management approach already used by the feature.

### Cubit

* Keep Cubits focused on one feature/responsibility.
* Keep business logic in the Cubit or appropriate lower layer.
* Keep API/database details out of UI.
* Follow existing loading, success, empty, and error-state patterns.
* Follow existing Cubit naming and file structure.

### ChangeNotifier

* Use for view-related logic when the project uses it.
* Keep controllers focused on presentation logic.
* Follow the existing `notifyListeners()` pattern.
* Do not duplicate the same responsibility between Controller and Cubit.

### Provider

* Follow the existing Provider scope and access pattern.
* Do not introduce another state-management mechanism when Provider already solves the problem.

---

# Repository Pattern

* Repositories handle data access and coordination.
* Follow existing repository naming, return types, error handling, and structure.
* Do not put UI logic in repositories.
* Do not create unnecessary repository abstractions.

---

# Dependency Injection

Use **GetIt** following the existing project structure.

* Register dependencies in the existing DI setup.
* Follow the existing registration style.
* Prefer constructor injection.
* Reuse existing `sl<T>()` dependencies.
* Do not manually instantiate services/repositories/controllers when GetIt already provides them.
* Do not introduce another DI solution.

---

# `main.dart` / Application Entry Point

Follow the existing `main.dart` structure exactly.

The current application root follows:

```text
ScreenUtilInit
    ↓
MultiBlocProvider
    ↓
MaterialApp.router
```

Preserve this structure unless explicitly requested otherwise.

The project uses:

* `ScreenUtilInit`
* `MultiBlocProvider`
* `MaterialApp.router`
* `AppRouter.router`
* `AppColors`
* `ThemeData`
* `GoogleFonts`
* GetIt (`sl<T>()`)

The existing style is the source of truth.

Example pattern:

```dart
@override
Widget build(BuildContext context) {
  return ScreenUtilInit(
    designSize: const Size(411.42857142857144, 832.7619047619048),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, widget) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(AuthRepoImpl())..checkAuth(),
          ),
          BlocProvider(
            create: (context) => UserProfileCubit(
              sl<UserProfileRepo>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Monumental Habits',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: AppColors.scaffoldColor,
            textTheme: GoogleFonts.manropeTextTheme().apply(
              bodyColor: AppColors.secondaryColor,
              displayColor: AppColors.secondaryColor,
            ),
          ),
          debugShowCheckedModeBanner: false,
        ),
      );
    },
  );
}
```

When adding a global Cubit, add it to the existing `MultiBlocProvider` and follow the same creation pattern.

Do not create another application initialization structure.

---

# Mobile-First Rule

**The Flutter mobile application is always the default target.**

Mobile is the **base UI** and the primary design target.

Unless explicitly requested:

* Build the mobile UI first.
* Treat mobile as the source layout.
* Do not redesign for web.
* Do not create desktop-specific navigation/layouts.
* Do not add web-specific behavior.
* Do not optimize the implementation around desktop/web.

Only create web/desktop-specific UI when explicitly requested, such as:

* "Make it work on web."
* "Add web support."
* "Create the desktop layout."
* "Make this responsive for web."

If the user does not mention web/desktop, **assume mobile only**.

---

# Responsive System

Follow the project's existing responsive system exactly.

The project uses:

* `ScreenUtilInit`
* `ResponsiveWidget`
* `responsiveSize(BuildContext context, double base)`
* `LayoutBuilder`
* `MediaQuery.sizeOf(context)`
* Existing breakpoints
* `AppStyles` for responsive text sizes

Do not introduce another responsive package, helper, breakpoint system, or responsive architecture unless explicitly requested.

### `ResponsiveWidget`

Use the existing pattern:

```dart
ResponsiveWidget(
  mobile: ...,
  tablet: ...,
  desktop: ...,
)
```

Existing breakpoints:

```text
< 790       → Mobile
790–1023    → Tablet
>= 1024     → Desktop
```

When only mobile is required, do not unnecessarily create tablet/desktop layouts.

### `responsiveSize`

Reuse the existing:

```dart
responsiveSize(context, baseSize)
```

for responsive sizing when appropriate.

Do not create another scaling function.

---

# Styling System

The project uses `AppStyles` for reusable responsive text styles.

Before creating a `TextStyle`:

1. Check `AppStyles`.
2. Check `AppColors`.
3. Check `ThemeData`.
4. Check existing reusable widgets/styles.

Follow the existing pattern:

```dart
AppStyles.textStyle14(context)
AppStyles.textStyle16(context)
AppStyles.textStyle18(context)
```

`AppStyles` uses:

```dart
fontSize: responsiveSize(context, base)
```

When a suitable style exists, reuse it.

Do not create a separate typography system or repeatedly hardcode text styles.

If a genuinely new reusable text style is needed, add it to the existing `AppStyles` class using the same naming and implementation pattern.

---

# Colors / Theme

* Reuse `AppColors`.
* Reuse existing `ThemeData`.
* Reuse existing text themes and fonts.
* Do not create duplicate colors.
* Do not introduce another theme/design-token system.
* Do not hardcode a color when an existing `AppColors` value can be used.

---

# Flutter Widgets

* Keep widgets focused and readable.
* Keep business logic outside widgets.
* Extract large sections when it improves readability.
* Reuse existing widgets before creating new ones.
* Use `const` whenever appropriate.
* Follow existing widget naming.
* Follow existing spacing, typography, colors, animations, and responsive patterns.
* Keep mobile as the default UI.

---

# Dart Style

* `camelCase` for variables, methods, parameters.
* `PascalCase` for classes, enums, extensions.
* `snake_case.dart` for files.
* Prefer `final`.
* Use `const` whenever appropriate.
* Use null safety correctly.
* Avoid unnecessary `!`.
* Use meaningful names.
* Keep methods focused.
* Prefer readable code over clever code.
* Follow the formatting already used in the project.

---

# Naming

Follow existing naming conventions.

Examples:

* `SomethingCubit`
* `SomethingController`
* `SomethingRepository`
* `SomethingModel`
* `SomethingPage`
* `SomethingScreen`
* `SomethingWidget`

Do not invent a different naming convention when an existing one applies.

---

# Folder Structure

Follow the existing project folder structure exactly.

For a new feature:

1. Find the closest existing feature.
2. Inspect its folders/files.
3. Replicate the same structure.
4. Replace only feature-specific parts.

Do not reorganize the project into another architecture.

---

# Error Handling

Follow existing error-handling patterns.

* Do not silently ignore errors.
* Handle expected failures consistently.
* Show user-friendly messages at the presentation layer.
* Do not expose unnecessary technical details.
* Do not introduce a completely different error-handling system for one feature.

---

# Code Reuse

Before creating something new, search the existing codebase.

Prefer:

1. Reuse an existing implementation.
2. Extend an existing implementation.
3. Create a new implementation only when necessary.

Avoid duplicate widgets, utilities, services, controllers, Cubits, repositories, styles, and responsive helpers.

---

# Comments

Keep comments minimal.

Only comment when explaining:

* Why something is implemented a specific way.
* A non-obvious business rule.
* A workaround or important technical decision.

Do not comment obvious code.

---

# Changes

When implementing a task:

* Make the smallest change necessary.
* Preserve existing behavior.
* Do not refactor unrelated code.
* Do not rename existing files/classes unless required.
* Do not change architecture unless explicitly requested.
* Do not introduce dependencies unless necessary.
* Do not replace existing packages with alternatives.
* Match surrounding code instead of applying generic patterns.

---

# Implementation Workflow

Before implementing:

1. **Inspect** similar screens, widgets, Cubits, controllers, repositories, DI registrations, styles, and responsive implementations.
2. **Identify** the architecture and patterns used by the closest existing feature.
3. **Reuse** existing code, utilities, styles, colors, widgets, dependencies, and state-management patterns.
4. **Implement** the smallest change necessary.
5. **Verify** architecture, naming, folder structure, responsiveness, mobile-first behavior, and code reuse.

---

# Most Important Rules

When generic Flutter best practices conflict with the existing project implementation:

**Follow the existing project implementation.**

When unsure:

1. Find an existing example.
2. Inspect how it is structured.
3. Follow the same pattern.
4. Reuse it.
5. Only introduce a new approach when no existing pattern applies.

### Final Priority

**Mobile first. Existing code first. Reuse first.**

New code must feel like it was written by the same developer who wrote the existing project.
