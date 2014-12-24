<?php
/**
 * The manifest of files that are local to specific environment.
 * This file returns a list of environments that the application
 * may be installed under. The returned data must be in the following
 * format:
 *
 * ```php
 * return [
 *     'environment name' => [
 *         'path' => 'directory storing the local files',
 *         'setWritable' => [
 *             // list of directories that should be set writable
 *         ],
 *         'setExecutable' => [
 *             // list of directories that should be set executable
 *         ],
 *         'setCookieValidationKey' => [
 *             // list of config files that need to be inserted with automatically generated cookie validation keys
 *         ],
 *         'createSymlink' => [
 *             // list of symlinks to be created. Keys are symlinks, and values are the targets.
 *         ],
 *     ],
 * ];
 * ```
 */
return [
    'dev' => [
        'path' => 'dev/_init',
        'configPath' => 'environments/dev',
        'setWritable' => [
            'common/runtime',
            'backend/runtime',
            'backend/web/assets',
            'frontend/runtime',
            'frontend/web/assets',
            'storage'
        ],
        'setExecutable' => [
            'environments/dev/backend/yii',
            'environments/dev/frontend/yii',
            'environments/dev/console/yii',
        ],
        'setCookieValidationKey' => [
            'environments/dev/backend/config/web-local.php',
            'environments/dev/frontend/config/web-local.php',
        ],
    ],
    'prod' => [
        'path' => 'prod/_init',
        'configPath' => 'environments/prod',
        'setWritable' => [
            'common/runtime',
            'backend/runtime',
            'backend/web/assets',
            'frontend/runtime',
            'frontend/web/assets',
            'storage'
        ],
        'setExecutable' => [
            'backend/yii',
            'frontend/yii',
            'console/yii',
        ],
        'setCookieValidationKey' => [
            'environments/prod/backend/config/web-local.php',
            'environments/prod/frontend/config/web-local.php',
        ],
    ],
];
