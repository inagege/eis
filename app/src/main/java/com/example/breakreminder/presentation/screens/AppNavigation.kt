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
                onNavigateToCoffee = {
                    navController.navigate("coffee_prompt")
                },
                onNavigateToYoga = {
                    navController.navigate("yoga_screen")
                },
                onNavigateToClean = {
                    navController.navigate("cleaning_prompt")
                },
                onNavigateToWalk = {
                    navController.navigate("walk_start")
                },


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
                onNavigateToCoffee = {
                    navController.navigate("coffee_prompt")
                },
                onNavigateToYoga = {
                    navController.navigate("yoga_screen")
                },
                onNavigateToClean = {
                    navController.navigate("cleaning_prompt")
                },
                onNavigateToWalk = {
                    navController.navigate("walk_start")
                },


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

        composable("coffee_prompt") {
            CoffeePromptScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onStartMachine = { navController.navigate("coffee_video") }
            )
        }

        composable("coffee_video") {
            CoffeeVideoScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onFinishCoffeeVideo = {
                    navController.navigate("coffee_screen") {
                        popUpTo("coffee_video") { inclusive = true }
                    }
                }
            )
        }

        composable("coffee_screen") {
            CoffeeScreen(
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

        composable("cleaning_prompt") {
            CleaningPromptScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onStartCleaning = { navController.navigate("cleaning_video") }
            )
        }

        composable("cleaning_video") {
            CleaningVideoScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onFinishCleaningVideo = { navController.navigate("cleaning_screen") }
            )
        }

        composable("cleaning_screen") {
            CleaningScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onBackToHome = { navController.navigate("home_screen") }
            )
        }
        composable("walk_start") {
            WalkStartScreen(
                onThemeChanged = onThemeChanged,
                isDarkMode = isDarkMode,
                onButtonColorChanged = onButtonColorChanged,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                onScreenSelectionChanged = onScreenSelectionChanged,
                screenSelection = screenSelection,
                onStartWalk = {
                    navController.navigate("walk_screen")
                }
            )
        }

        composable("walk_screen") {
            WalkScreen(
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
