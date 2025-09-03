# 첫 번째 스테이지: 빌드 스테이지
FROM gradle:jdk-21-graal-jammy AS builder

# 작업 디렉토리 설정
# 이 WORKDIR이 프로젝트의 루트 디렉터리가 됩니다.
WORKDIR /app

# Gradle Wrapper와 관련된 파일, build/settings 파일 복사
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .

# 필요한 모든 서브 모듈 디렉터리 복사
# 이렇게 해야 back 모듈의 build.gradle과 src 코드가 컨테이너에 들어갑니다.
COPY back ./back
COPY front ./front

# 종속성 미리 다운로드
# 이렇게 하면 나중에 소스 코드만 변경됐을 때 캐시를 재사용할 수 있습니다.
RUN ./gradlew dependencies --no-daemon

# 애플리케이션 빌드
RUN ./gradlew build --no-daemon -x test

# 두 번째 스테이지: 실행 스테이지
FROM container-registry.oracle.com/graalvm/jdk:21

# 작업 디렉토리 설정
WORKDIR /app

# 첫 번째 스테이지에서 빌드된 JAR 파일 복사
# back 모듈의 빌드 결과물(jar)을 복사합니다.
COPY --from=builder /app/back/build/libs/*.jar app.jar
COPY --from=builder /app/.env .env

# 실행할 JAR 파일 지정
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]