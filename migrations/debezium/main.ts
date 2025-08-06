import { exists, walk } from 'jsr:@std/fs@1.0.19';

const basePath = import.meta.dirname;

if (Deno.args.length < 1 || !['main'].includes(Deno.args[0])) {
  log.error('Missing required argument: main');
  Deno.exit(1);
}

if (!await checkIfHurlExists()) {
  log.error('hurl is not installed');
  Deno.exit(1);
}

const base = walk(`${basePath}/${Deno.args[0]}`, { includeDirs: true, exts: ['.hurl'], match: [new RegExp(/^base/)] });
const nonBase = walk(`${basePath}/${Deno.args[0]}`, { includeDirs: true, exts: ['.hurl'], skip: [new RegExp(/^base/)] });

for await (const e of base) {
  await processHurlFile(e.path);
}

for await (const e of nonBase) {
  await processHurlFile(e.path);
}

async function processHurlFile(hurlFile: string) {
  const mustacheFile = hurlFile.replace('.hurl', '.mustache');

  const variables = [
    '--variable',
    `url=${Deno.env.get('HURL_VAR_URL')}`,
    '--variable',
    `environment=${Deno.env.get('HURL_VAR_ENVIRONMENT')}`,
    '--variable',
    `db_hostname=${Deno.env.get('HURL_VAR_DB_HOSTNAME')}`,
    '--variable',
    `db_port=${Deno.env.get('HURL_VAR_DB_PORT')}`,
    '--variable',
    `db_user=${Deno.env.get('HURL_VAR_DB_USER')}`,
    '--variable',
    `db_password=${Deno.env.get('HURL_VAR_DB_PASSWORD')}`,
  ];

  if (await exists(mustacheFile)) {
    const file = await Deno.readFile(mustacheFile);
    const mustache = JSON.stringify(new TextDecoder().decode(file));
    variables.push('--variable', `mustache=${mustache}`);
  }

  const cmd = await new Deno.Command('hurl', { args: [...variables, hurlFile] }).output();

  console.info('-----------------------------------');
  console.info('Processing file: ' + hurlFile);

  if (cmd.success === false) {
    console.error('Status: Failed');
    console.error('Output:');
    console.error(new TextDecoder().decode(cmd.stderr));
    Deno.exit(1);
  } else {
    console.info('Status: Success');
    console.info('Output:');
    console.info(new TextDecoder().decode(cmd.stdout));
  }
}

async function checkIfHurlExists() {
  try {
    await new Deno.Command('hurl', { args: ['--version'] }).output();
    return true;
  } catch {
    return false;
  }
}
