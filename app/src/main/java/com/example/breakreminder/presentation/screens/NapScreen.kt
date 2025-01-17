package com.example.breakreminder.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Bed
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
 * NapStartScreen - Shows nap prompt before starting the actual nap timer
 */
@Composable
fun NapStartScreen(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    onStartNap: () -> Unit = {}  // Navigation callback
) {
    Scaffold { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Icon at the top (same as WalkScreen)
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .offset(y = 10.dp)
                    .background(buttonColor, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Bed,
                    contentDescription = "Nap Icon",
                    tint = buttonTextColor,
                    modifier = Modifier.size(15.dp)
                )
            }

            Spacer(modifier = Modifier.height(18.dp))

            // Nap Prompt
            Text(
                text = "Ready to take a 5-minute nap?",
                fontSize = 24.sp,
                color = if (isDarkMode) buttonColor else buttonTextColor,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.height(2.dp))

            Icon(
                imageVector = Icons.Default.Bed,
                contentDescription = "Nap Icon",
                tint = if (isDarkMode) buttonColor else buttonTextColor,
                modifier = Modifier.size(30.dp)
            )

            Spacer(modifier = Modifier.height(2.dp)) // Pushes button to the bottom (same height as WalkScreen)

            ElevatedButton(
                onClick = { onStartNap() },
                colors = ButtonDefaults.buttonColors(
                    containerColor = buttonColor,
                    contentColor = buttonTextColor
                ),
                modifier = Modifier
                    .width(170.dp)
                    .height(50.dp)
            ) {
                Text(text = "Start Nap", fontSize = 18.sp)
            }

            Spacer(modifier = Modifier.height(20.dp)) // Keeps the bottom padding consistent
        }
    }
}

/**
 * NapScreen - Timer countdown for 5-minute nap
 */
@Composable
fun NapScreen(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    onBackToHome: () -> Unit = {}  // Callback when nap ends
) {
    var remainingTime by remember { mutableStateOf(5 * 60) } // 5-minute countdown
    var isFinished by remember { mutableStateOf(false) }

    // Start the Timer
    LaunchedEffect(Unit) {
        while (remainingTime > 0) {
            delay(1000)
            remainingTime--
        }
        isFinished = true
    }

    val minutes = remainingTime / 60
    val seconds = remainingTime % 60

    Scaffold { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(horizontal = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Icon at the top (same as WalkScreen)
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .offset(y = 10.dp)
                    .background(buttonColor, CircleShape),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Bed,
                    contentDescription = "Nap Icon",
                    tint = buttonTextColor,
                    modifier = Modifier.size(15.dp)
                )
            }

            Spacer(modifier = Modifier.height(10.dp))

            // Timer
            Text(
                text = "Time left: ${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}",
                fontSize = 18.sp,
                color = if (isDarkMode) buttonColor else buttonTextColor,
                fontWeight = FontWeight.Bold,
                textAlign = TextAlign.Center
            )

            Spacer(modifier = Modifier.height(4.dp))

            // Nap GIF Animation using GlideImage
            GlideImage(
                imageModel = { "android.resource://com.example.breakreminder/${R.raw.sleep_animation}" },
                modifier = Modifier
                    .width(70.dp)  // Adjust width dynamically
                    .aspectRatio(200f / 175f) // Maintain original aspect ratio
            )

            Spacer(modifier = Modifier.height(4.dp)) // Pushes button to the same height as WalkScreen

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

            Spacer(modifier = Modifier.height(20.dp)) // Keeps spacing consistent
        }
    }
}
