import { NestFactory } from '@nestjs/core';
import serverlessExpress from '@vendia/serverless-express';
import { Callback, Context, Handler } from 'aws-lambda';
import helmet from 'helmet';

import { AppModule } from './app.module';

const port = process.env.PORT || 4000;

let server: Handler;


async function bootstrap(): Promise<Handler> {
  const app = await NestFactory.create(AppModule);
  app.enableCors({
    origin: (req, callback) => callback(null, true),
  });
  app.use(helmet());
  await app.init();

  const expressApp = app.getHttpAdapter().getInstance();
  return serverlessExpress({ app: expressApp });
}

export const handler: Handler = async (
  event: any,
  context: Context,
  callback: Callback,
) => {
  server = server ?? (await bootstrap());
  console.log('App is running');
  return server(event, context, callback);
};