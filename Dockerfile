# ビルドステージ（Gradleの公式イメージを使用）
FROM gradle:6.9-jdk8 AS builder
WORKDIR /app
COPY . .

# プロジェクトをビルド
RUN gradle clean build -x test

# 実行用イメージの生成
FROM openjdk:8-jdk-alpine
WORKDIR /app

# ビルド成果物（JARファイル）をコピー
COPY --from=builder /app/build/libs/ecsite-1.0.0-BUILD-SNAPSHOT.jar app.jar

# アプリケーションを実行
ENTRYPOINT ["java", "-jar", "app.jar"]
