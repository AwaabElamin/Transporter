<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
      //  Eloquent::unguard();

        //$this->call('UserTableSeeder');
       // $this->command->info('User table seeded!');

        $path = 'license/includes/db_Alnaqel.sql';
       // DB::unprepared(file_get_contents($path));
        //$this->command->info('Country table seeded!');
        $process = new Process([
            'mysql',
            '-h',
            DB::getConfig('host'),
            '-u',
            DB::getConfig('username'),
            '-p' . DB::getConfig('password'),
            DB::getConfig('database'),
            '-e',
            $path 
        ]);
        $process->mustRun();
    }
}
