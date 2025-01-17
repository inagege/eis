package com.example.breakreminder.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Coffee
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.*
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.*
import com.example.breakreminder.R
import com.skydoves.landscapist.glide.GlideImage
import kotlinx.coroutines.delay

/**
 * 1) CoffeePromptScreen
 *   - Zeigt Kreis + Icon oben
 *   - Text "How about a coffee break?"
 *   - Button "Start machine!" -> navigiert zu CoffeeVideoScreen
 */
@Composable
fun CoffeePromptScreen(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    onStartMachine: () -> Unit = {}
) {
    Scaffold { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Icon-Kreis oben
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .offset(y = 10.dp)
                    .background(buttonColor, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Coffee,
                    contentDescription = "Coffee Icon",
                    tint = buttonTextColor,
                    modifier = Modifier.size(15.dp)
                )
            }

            Spacer(modifier = Modifier.height(28.dp))

            // Text
            Text(
                text = "How about a coffee break?",
                fontSize = 24.sp,
                color = if (isDarkMode) buttonColor else buttonTextColor,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.height(24.dp))

            // Button "Start machine!"
            ElevatedButton(
                onClick = { onStartMachine() },
                colors = ButtonDefaults.buttonColors(
                    containerColor = buttonColor,
                    contentColor = buttonTextColor
                ),
                modifier = Modifier
                    .width(170.dp)
                    .height(50.dp)
            ) {
                Text(text = "Start machine!", fontSize = 18.sp)
            }
        }
    }
}

/**
 * 2) CoffeeVideoScreen
 *   - Zeigt oben Icon
 *   - Spielt coffee.gif (ca. 8s) + 2 Durchläufe => 16s
 *   - Danach -> CoffeeScreen
 */
@Composable
fun CoffeeVideoScreen(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    onFinishCoffeeVideo: () -> Unit = {}
) {
    // 2x8 Sekunden ablaufen -> fertig
    var playCount by remember { mutableStateOf(0) }

    // Timer / Schleife
    LaunchedEffect(Unit) {
        while (playCount < 2) {
            delay(8000)
            playCount++
        }
        // Dann 1s Delay + Wechsel zum CoffeeScreen
        delay(1000)
        onFinishCoffeeVideo()
    }

    // Resource-Pfad
    val context = LocalContext.current
    val packageName = context.packageName
    val gifUri = "android.resource://$packageName/${R.raw.coffee}"

    Scaffold { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Icon-Kreis oben
            Box(
                modifier = Modifier
                    .offset(y = 10.dp)
                    .size(20.dp)
                    .background(buttonColor, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Coffee,
                    contentDescription = "Coffee Icon",
                    tint = buttonTextColor,
                    modifier = Modifier.size(15.dp)
                )
            }

            Spacer(modifier = Modifier.height(35.dp))

            // Das animierte GIF via GlideImage (Landscapist)
            GlideImage(
                imageModel = { "android.resource://com.example.breakreminder/${R.raw.coffee}" },
                modifier = Modifier.size(110.dp)
            )
        }
    }
}

/**
 * 3) CoffeeScreen
 *   - Zeigt "Your coffee is ready!"
 *   - Button "Back to Home"
 */
@Composable
fun CoffeeScreen(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    onBackToHome: () -> Unit = {}
) {
    Scaffold { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Icon-Kreis oben
            Box(
                modifier = Modifier
                    .offset(y = 10.dp)
                    .size(20.dp)
                    .background(buttonColor, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Coffee,
                    contentDescription = "Coffee Icon",
                    tint = buttonTextColor,
                    modifier = Modifier.size(15.dp)
                )
            }

            Spacer(modifier = Modifier.height(28.dp))

            Text(
                text = "Your coffee is ready!",
                fontSize = 24.sp,
                color = if (isDarkMode) buttonColor else buttonTextColor,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.height(24.dp))

            ElevatedButton(
                onClick = { onBackToHome() },
                colors = ButtonDefaults.buttonColors(
                    containerColor = buttonColor,
                    contentColor = buttonTextColor
                ),
                modifier = Modifier
                    .width(170.dp)
                    .height(50.dp)
            ) {
                Text(text = "Back to Home", fontSize = 18.sp)
            }
        }
    }
}
