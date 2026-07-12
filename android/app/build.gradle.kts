
import java.io.FileInputStream
import java.util.Properties

// 프로젝트 루트(../.env)의 .env 파일 읽어오기
val env = Properties().apply {
    val envFile = rootProject.file("../.env")
    if (envFile.exists()) {
        load(FileInputStream(envFile))
    }
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.aac"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.aac"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // .env에서 값을 꺼내와 매니페스트 변수로 등록합니다.
        manifestPlaceholders["naverClientId"] = env.getProperty("NAVER_CLIENT_ID") ?: ""
        manifestPlaceholders["naverClientSecret"] = env.getProperty("NAVER_CLIENT_SECRET") ?: ""
        manifestPlaceholders["naverClientName"] = env.getProperty("NAVER_CLIENT_NAME") ?: ""
        
        // 💡 카카오 스키마도 숨기고 싶다면 여기에 함께 추가 가능합니다!
        val kakaoKey = env.getProperty("KAKAO_NATIVE_APP_KEY") ?: ""
        manifestPlaceholders["kakaoScheme"] = "kakao$kakaoKey"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
