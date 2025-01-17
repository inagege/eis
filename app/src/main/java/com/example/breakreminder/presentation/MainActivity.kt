package com.example.breakreminder.presentation

import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.ui.graphics.Color

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // SharedPreferences laden
        val prefs = getSharedPreferences("EISPreferences", Context.MODE_PRIVATE)
        val isDarkMode = prefs.getBoolean("isDarkMode", false)
        val buttonColorInt = prefs.getInt("buttonColor", 0xFFFFC0CB.toInt())
        val buttonTextColorInt = prefs.getInt("buttonTextColor", 0xFF4D2324.toInt())
        val buttonColor = Color(buttonColorInt)
        val buttonTextColor = Color(buttonTextColorInt)
        val screenSelection = prefs.getString("ScreenSelection", "Grid") ?: "Grid"
        val firstStart = isFirstRun(prefs)

        setContent {
            EISApp(
                firstStart = firstStart,
                isDarkMode = isDarkMode,
                buttonColor = buttonColor,
                buttonTextColor = buttonTextColor,
                screenSelection = screenSelection
            )
        }
    }

    private fun isFirstRun(prefs: SharedPreferences): Boolean {
        val key = "firstRun"
        val firstRun = prefs.getBoolean(key, true)
        if (firstRun) {
            prefs.edit().putBoolean(key, false).apply()
        }
        return firstRun
    }
}
