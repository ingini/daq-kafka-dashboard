# ============================================================
#  daq-kafka-dashboard  APK 빌드 이미지
#  결과물: build/app/outputs/flutter-apk/app-release.apk
# ============================================================

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip xz-utils git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ── Java 17 ──────────────────────────────────────────────────
WORKDIR /opt
RUN curl -fsSL https://download.java.net/openjdk/jdk17/ri/openjdk-17+35_linux-x64_bin.tar.gz \
    | tar xz
ENV JAVA_HOME=/opt/jdk-17
ENV PATH=$PATH:$JAVA_HOME/bin

# ── Flutter 3.19.6 ───────────────────────────────────────────
RUN curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz \
    | tar xJ -C /opt
ENV FLUTTER_HOME=/opt/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin

# ── Android SDK ───────────────────────────────────────────────
WORKDIR /opt/android-sdk
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

RUN curl -fsSL https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip \
    -o cmdline-tools.zip \
    && unzip -q cmdline-tools.zip \
    && rm cmdline-tools.zip \
    && mkdir -p cmdline-tools/latest \
    && mv cmdline-tools/bin cmdline-tools/lib \
    cmdline-tools/NOTICE.txt cmdline-tools/source.properties \
    cmdline-tools/latest/ \
    && yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.2"

# ── Gradle wrapper 캐시 (오프라인 빌드용, 없으면 빌드 시 다운로드) ─
# COPY gradle-7.5-all.zip /root/.gradle/wrapper/dists/gradle-7.5-all/6qsw290k5lz422uaf8jf6m7co/

# ── 앱 소스 ──────────────────────────────────────────────────
WORKDIR /app
COPY . .

RUN git config --global --add safe.directory /opt/flutter

# pub get + APK 빌드
RUN flutter pub get && \
    flutter build apk --release --target-platform=android-arm64

# 결과물 복사용 레이어 (CI에서 docker cp 로 꺼낼 것)
# 결과물 위치: /app/build/app/outputs/flutter-apk/app-release.apk
