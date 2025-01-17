package com.example.breakreminder.presentation

import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController

@Composable
fun AppNavigation(
    firstStart: Boolean,
    isDarkMode: Boolean,
    buttonColor: Color,
    buttonTextColor: Color,
    screenSelection: String,
    onThemeChanged: (Boolean) -> Unit,
    onButtonColorChanged: (Color, Color) -> Unit,
    onScreenSelectionChanged: (String) -> Unit
) {
    val navController = rememberNavController()
    val startDestination = if (firstStart) "setup_screen" else "home_screen"

    NavHost(
        navController = navController,
        startDestination = startDestination
    ) {
        // SetupScreen
        composable("setup_screen") {
            SetupScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onNavigateToHome = {
                    navController.navigate("home_screen") {
                        popUpTo("setup_screen") { inclusive = true }
                    }
                },
                onDeny = {
                    // Z. B. App schließen oder Reset
                }
            )
        }

        // HomeScreen
        composable("home_screen") {
            HomeScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onNavigateToSettings = {
                    navController.navigate("settings_screen")
                },
                onNavigateToSelection = {
                    if (screenSelection == "Grid") {
                        navController.navigate("selection_screen")
                    } else {
                        navController.navigate("selection_swipe_screen")
                    }
                }
            )
        }

        // SettingsScreen
        composable("settings_screen") {
            SettingsScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onNavigateBack = {
                    navController.popBackStack()
                }
            )
        }

        // SelectionScreen
        composable("selection_screen") {
            SelectionScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onNavigateToYoga = {
                    navController.navigate("yoga_screen")
                }

            )
        }

        // SelectionSwipeScreen
        composable("selection_swipe_screen") {
            SelectionSwipeScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onNavigateToYoga = {
                    navController.navigate("yoga_screen")
                }

            )
        }

        composable("yoga_screen") {
            YogaScreens(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onBackToHome = {
                    navController.navigate("home_screen") {
                        popUpTo("home_screen")
                    }
                }
            )
        }


        // Weitere Screens (Yoga, Nap, Coffee, Clean, etc.) könntest du hier ergänzen.
    }
}
