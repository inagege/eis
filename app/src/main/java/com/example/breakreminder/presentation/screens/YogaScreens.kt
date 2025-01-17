package com.example.breakreminder.presentation

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.*
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.breakreminder.R
import kotlinx.coroutines.delay

data class YogaScreenData(
    val title: String,
    val description: String? = null,
    val buttonText: String,
    val imageRes: Int? = null,
    val imageWidthDp: Float = 100f,
    val imageHeightDp: Float = 50f
)

// Beispiel-Liste
val yogaScreensList = listOf(
    YogaScreenData("5 exercises each\n60 seconds!", buttonText = "Start Session!"),
    YogaScreenData("Yoga 1/5", buttonText = "Next", imageRes = R.drawable.yoga1),
    YogaScreenData("Yoga 2/5", buttonText = "Next", imageRes = R.drawable.yoga2),
    YogaScreenData("Yoga 3/5", buttonText = "Next", imageRes = R.drawable.yoga3),
    YogaScreenData("Yoga 4/5", buttonText = "Next", imageRes = R.drawable.yoga4),
    YogaScreenData("Yoga 5/5", buttonText = "Next", imageRes = R.drawable.yoga5),
    YogaScreenData("Yoga session\ncompleted", buttonText = "Back to Home")
)

/**
 * YogaScreens mit einer Logik:
 * - Button immer etwa an selber Höhe (mit Spacer)
 * - Wenn ein Bild da ist: Timer, Bild, dann Text
 * - Wenn kein Bild da ist: Text mittig zwischen Icon und Button
 */
@Composable
fun YogaScreens(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    onBackToHome: () -> Unit = {}
) {
    var currentIndex by remember { mutableStateOf(0) }
    var remainingTime by remember { mutableStateOf(60) }

    val screens = yogaScreensList
    val screen = screens[currentIndex]

    // Timer-Logik
    LaunchedEffect(key1 = currentIndex) {
        if (currentIndex in 1..5 && screen.imageRes != null) {
            remainingTime = 60
            while (remainingTime > 0) {
                delay(1000)
                remainingTime--
            }
            moveToNextScreen(currentIndex, screens.size) { newIndex ->
                currentIndex = newIndex
            }
        }
    }

    Scaffold { innerPadding ->
        // Column, in der wir den Button unten oder "fast unten" platzieren.
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // 1) Kleiner Icon-Kreis oben, wie SelectionScreen
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .offset(y = 10.dp)
                    .background(buttonColor, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                // Yoga-Icon
                Image(
                    painter = painterResource(id = R.drawable.yogaicon),
                    contentDescription = "Yoga Icon",
                    modifier = Modifier.size(15.dp)
                )
            }

            // Kurzer Spacer, damit etwas Abstand zum Icon ist
            Spacer(modifier = Modifier.height(5.dp))

            if (screen.imageRes != null) {
                // 2) Wenn ein Bild da ist:
                //    Timer + Bild + Titel + evtl. description
                //    Danach Spacer.weight(...) => Button
                // Timer (index 1..5)
                if (currentIndex in 1..5) {
                    Text(
                        text = "$remainingTime seconds",
                        fontSize = 18.sp,
                        textAlign = TextAlign.Center
                    )
                    Spacer(modifier = Modifier.height(5.dp))
                } else {
                    // Falls wir "Screen 0" oder "Screen 6" haben,
                    // kommt ggf. kein Timer
                }

                // Bild
                Image(
                    painter = painterResource(id = screen.imageRes),
                    contentDescription = screen.title,
                    modifier = Modifier.size(
                        width = screen.imageWidthDp.dp,
                        height = screen.imageHeightDp.dp
                    )
                )

                Spacer(modifier = Modifier.height(10.dp))

                // Titel
                Text(
                    text = screen.title,
                    fontSize = 24.sp,
                    color = if (isDarkMode) buttonColor else buttonTextColor,
                    textAlign = TextAlign.Center
                )

                // Optional description
                if (!screen.description.isNullOrEmpty()) {
                    Spacer(modifier = Modifier.height(10.dp))
                    Text(
                        text = screen.description,
                        fontSize = 20.sp,
                        color = if (isDarkMode) buttonColor else buttonTextColor,
                        textAlign = TextAlign.Center
                    )
                }

                // Spacer mit weight => Button rutscht nach unten
                Spacer(modifier = Modifier.weight(1f))

            } else {
                // 3) Wenn KEIN Bild => Text soll mittig zwischen Icon und Button sein
                //    -> Wir nutzen Spacer.weight(1f) vor dem Text und Spacer.weight(1f) nach dem Text
                Spacer(modifier = Modifier.weight(1f))

                // Titel
                Text(
                    text = screen.title,
                    fontSize = 24.sp,
                    color = if (isDarkMode) buttonColor else buttonTextColor,
                    textAlign = TextAlign.Center
                )

                // Optional description
                if (!screen.description.isNullOrEmpty()) {
                    Spacer(modifier = Modifier.height(10.dp))
                    Text(
                        text = screen.description,
                        fontSize = 20.sp,
                        color = if (isDarkMode) buttonColor else buttonTextColor,
                        textAlign = TextAlign.Center
                    )
                }

                Spacer(modifier = Modifier.weight(1f))
            }

            // 4) Button (ganz unten)
            Button(
                onClick = {
                    if (currentIndex < screens.size - 1) {
                        currentIndex++
                    } else {
                        onBackToHome()
                    }
                },
                colors = ButtonDefaults.buttonColors(
                    containerColor = buttonColor,
                    contentColor = buttonTextColor
                ),
                modifier = Modifier
                    .width(170.dp)
                    .height(50.dp)
            ) {
                Text(text = screen.buttonText, fontSize = 18.sp)
            }

            Spacer(modifier = Modifier.height(20.dp))
        }
    }
}

private fun moveToNextScreen(
    currentIndex: Int,
    totalScreens: Int,
    onIndexChange: (Int) -> Unit
) {
    if (currentIndex < totalScreens - 1) {
        onIndexChange(currentIndex + 1)
    }
}
