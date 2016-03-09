<?php

if ( !isset($_SERVER['HTTPS']) || $_SERVER['HTTPS'] == '' || $_SERVER['HTTPS'] == 'off' ) {
  header('HTTP/1.1 301 Moved Permanently');
  header('Location: https://' . $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
  exit;
}

///////////////////////////////////////////////////////////////////////////////
// CONFIG
///////////////////////////////////////////////////////////////////////////////

error_reporting(0);

$root = __DIR__;

$stampf = 'Y/m/d H:i:s';

$ignores = [
  $root . '/favicon.ico',
  $root . '/favicon.png',
  $root . '/logo.png',
  $root . '/index.php',
  $root . '/robots.txt',
  $root . '/sitemap.xml',
  $root . '/styles.css'
];

///////////////////////////////////////////////////////////////////////////////
// INIT
///////////////////////////////////////////////////////////////////////////////

$input    = $_SERVER['REQUEST_URI'];
$list     = [];
$readme   = null;
$mdsums   = null;
$shasums  = null;

$directory = preg_replace('/\/+/', '/', str_replace(['./', '../'], '/', $input));
if ( $directory === '/' ) {
  $directory = '';
}

$scandir = $root . $directory;
if ( !is_dir($scandir) ) {
  header('HTTP/1.0 404 Not Found');
  print '404 - Not found';
  exit;
}

///////////////////////////////////////////////////////////////////////////////
// MAIN
///////////////////////////////////////////////////////////////////////////////

if ( ($files = scandir($scandir)) !== false ) {
  $path = $scandir . '/README';
  if ( is_file($path) ) {
    $readme = file_get_contents($path);
  }

  $path = $scandir . '/MD5SUMS';
  if ( is_file($path) ) {
    $mdsums = file_get_contents($path);
  }

  $path = $scandir . '/SHA256SUMS';
  if ( is_file($path) ) {
    $shasums = file_get_contents($path);
  }

  foreach ( array_slice($files, 1) as $file ) {
    if ( $file === '..' && $directory ) { // Backwards
      $splitted = explode('/', $directory);
      if ( !array_pop($splitted) ) {
        array_pop($splitted);
      }

      $list[] = [
        'href' => implode('/', $splitted) ?: '/',
        'name' => '..',
        'date' => '-',
        'size' => '-'
      ];
      continue;
    }

    if ( substr($file, 0, 1) === '.' ) { // Hidden files
      continue;
    }

    $path = $scandir . '/' . $file;
    if ( in_array($path, $ignores) ) {
      continue;
    }

    $hs = '-';

    if ( !($isdir = @is_dir($path)) ) {
      if ( $bytes = @filesize($path) ) {
        $sz = 'BKMGTP';
        $factor = floor((strlen($bytes) - 1) / 3);
        $hs = sprintf('%.2f', $bytes / pow(1024, $factor)) . @$sz[$factor];
      }
    }

    $list[] = [
      'href' => preg_replace('/\/+/', '/', $directory . '/' . $file),
      'name' => $file . ($isdir ? '/' : ''),
      'date' => date($stampf, filemtime($path)),
      'size' => $hs
    ];
  }
}

///////////////////////////////////////////////////////////////////////////////
// CGI
///////////////////////////////////////////////////////////////////////////////

?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>OS.js Builds - Index of <?php echo htmlspecialchars($directory ?: '/'); ?></title>
    <link rel="stylesheet" type="text/css" href="/styles.css" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Source+Sans+Pro" />
  </head>
  <body>

    <header>
      <img alt="OS.js Logo" src="/logo.png" />
    </header>

    <main>
      <h1>Index of <?php echo htmlspecialchars($directory ?: '/'); ?></h1>

<?php if ( $readme ) { ?>

      <pre><?php print htmlspecialchars($readme); ?></pre>

<?php } ?>
<?php if ( $mdsums ) { ?>

      <pre>MD5 Checksums

<?php print htmlspecialchars($mdsums); ?></pre>

<?php } ?>
<?php if ( $shasums ) { ?>

      <pre>SHA256 Checksums

<?php print htmlspecialchars($shasums); ?></pre>

<?php } ?>

      <table>
        <thead>
          <tr>
            <th>Filename</th>
            <th>Last modified</th>
            <th>Size</th>
          </tr>
        </thead>
        <tbody>

<?php foreach ( $list as $item ) {

  print <<<EOHTML

          <tr>
            <td><a href="{$item['href']}">{$item['name']}</a></td>
            <td>{$item['date']}</td>
            <td>{$item['size']}</td>
          </tr>

EOHTML;

} ?>

        </tbody>
      </table>
    </main>

    <footer>
      Copyright &copy; 2011-2016 Anders Evenrud
    </footer>

    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-74874706-1', 'auto');
      ga('send', 'pageview');
    </script>
  </body>
</html>
