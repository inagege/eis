package com.example.breakreminder.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectTapGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Air
import androidx.compose.material.icons.filled.Bed
import androidx.compose.material.icons.filled.CleaningServices
import androidx.compose.material.icons.filled.DirectionsWalk
import androidx.compose.material.icons.filled.HourglassBottom
import androidx.compose.material.icons.filled.LocalCafe
import androidx.compose.material.icons.filled.SelfImprovement
import androidx.compose.material3.Icon
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.*
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun SelectionSwipeScreen(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    // Navigation-Callbacks (analog zum Flutter-Switch):
    onNavigateToYoga: () -> Unit = {},
    onNavigateToWalk: () -> Unit = {},
    onNavigateToNap: () -> Unit = {},
    onNavigateToVent: () -> Unit = {},
    onNavigateToCoffee: () -> Unit = {},
    onNavigateToClean: () -> Unit = {}
) {
    // 1) Aktivitäten-Liste (Name + Icon)
    val activities = listOf(
        ActivityData("Yoga", Icons.Default.SelfImprovement),
        ActivityData("Walk", Icons.Default.DirectionsWalk),
        ActivityData("Nap", Icons.Default.Bed),
        ActivityData("Vent", Icons.Default.Air),
        ActivityData("Coffee", Icons.Default.LocalCafe),
        ActivityData("Clean", Icons.Default.CleaningServices)
    )

    // 2) Ermitteln der Bildschirmgröße (Breite, Höhe)
    val config = LocalConfiguration.current
    val screenWidth = config.screenWidthDp.dp
    val screenHeight = config.screenHeightDp.dp

    // 3) Scaffold (kein Back-Button, kein Indikator)
    Scaffold { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
        ) {
            // Kleiner Kreis (hourglass_bottom) oben
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .offset(y = 10.dp)
                    .align(Alignment.CenterHorizontally)
                    .background(buttonColor, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.HourglassBottom,
                    contentDescription = "Hourglass",
                    tint = buttonTextColor,
                    modifier = Modifier.size(15.dp)
                )
            }

            Spacer(modifier = Modifier.height(5.dp))

            // 4) "Swipe"-Layout ohne Accompanist
            //    Wir nehmen eine LazyRow, jedes Item füllt die gesamte Bildschirmbreite
            LazyRow(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
            ) {
                items(activities) { activity ->
                    // Ein "Bildschirm" pro Item
                    Box(
                        modifier = Modifier
                            // Füllt den gesamten Bildschirm -> 1 Item pro "Seite"
                            .width(screenWidth)
                            .height(screenHeight - 70.dp)  // Abzug für Circle oben, etc.
                            .pointerInput(Unit) {
                                detectTapGestures(
                                    onTap = {
                                        // Tippen -> analoges Switch-Case wie in Flutter
                                        when (activity.name) {
                                            "Yoga" -> onNavigateToYoga()
                                            "Walk" -> onNavigateToWalk()
                                            "Nap" -> onNavigateToNap()
                                            "Vent" -> onNavigateToVent()
                                            "Coffee" -> onNavigateToCoffee()
                                            "Clean" -> onNavigateToClean()
                                        }
                                    }
                                )
                            },
                        contentAlignment = Alignment.Center
                    ) {
                        // Icon + Text zentriert
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Icon(
                                imageVector = activity.icon,
                                contentDescription = activity.name,
                                tint = if (isDarkMode) buttonColor else buttonTextColor,
                                modifier = Modifier.size(100.dp)
                            )
                            Spacer(modifier = Modifier.height(10.dp))
                            Text(
                                text = activity.name,
                                fontSize = 20.sp,
                                fontWeight = FontWeight.Normal,
                                color = if (isDarkMode) buttonColor else buttonTextColor
                            )
                        }
                    }
                }
            }
        }
    }
}

// Kleine Datenklasse, um Name + Icon zusammenzuhalten
data class ActivityData(
    val name: String,
    val icon: androidx.compose.ui.graphics.vector.ImageVector
)
