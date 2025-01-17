package com.example.breakreminder.presentation

import android.app.Activity
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun SetupScreen(
    onThemeChanged: (Boolean) -> Unit,
    isDarkMode: Boolean,
    onButtonColorChanged: (Color, Color) -> Unit,
    buttonColor: Color,
    buttonTextColor: Color,
    onScreenSelectionChanged: (String) -> Unit,
    screenSelection: String,
    onNavigateToHome: () -> Unit,
    onDeny: () -> Unit
) {
    val activity = LocalContext.current as? Activity

    Scaffold { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Box(
                modifier = Modifier
                    .size(20.dp)
                    .background(buttonColor),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Settings,
                    contentDescription = "Settings Icon",
                    tint = buttonTextColor,
                    modifier = Modifier.size(15.dp)
                )
            }
            Spacer(modifier = Modifier.height(5.dp))

            Text(text = "This app requires\naccess to:", fontSize = 18.sp)
            Spacer(modifier = Modifier.height(2.dp))
            Text(text = "Local Network Devices\nSamsung Health", fontSize = 16.sp)
            Spacer(modifier = Modifier.height(5.dp))

            Row(
                horizontalArrangement = Arrangement.SpaceEvenly,
                modifier = Modifier.fillMaxWidth()
            ) {
                Button(
                    onClick = {
                        // z. B. onDeny() -> activity?.finish()
                        onDeny()
                    },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = Color.Red,
                        contentColor = Color.White
                    ),
                    modifier = Modifier
                        .width(90.dp)
                        .height(50.dp)
                ) {
                    Text("Deny")
                }

                Button(
                    onClick = {
                        // Weiter zum Home-Screen
                        onNavigateToHome()
                    },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = Color.Green,
                        contentColor = Color.White
                    ),
                    modifier = Modifier
                        .width(90.dp)
                        .height(50.dp)
                ) {
                    Text("Agree")
                }
            }
        }
    }
}
