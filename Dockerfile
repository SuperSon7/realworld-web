# Node 환경에서 프론트 빌드
FROM node:22-alpine AS build

WORKDIR /app

RUN npm install -g pnpm@10.33.0

COPY . .

RUN pnpm install --frozen-lockfile
RUN pnpm build

# 빌드 결과만 Nginx에 복사
FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

# 컨테이너가 실행되는 동안 Nginx 유지
CMD ["nginx", "-g", "daemon off;"]
