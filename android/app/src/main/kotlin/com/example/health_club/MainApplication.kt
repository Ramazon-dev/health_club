package com.example.health_club

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("ru_RU")
        MapKitFactory.setApiKey("49bc56a3-1943-4c80-b687-9e92e5859053")
        MapKitFactory.initialize(this)
    }
}
