## Guia de "Instalacion"
	Basada en Windows 10

### Guia de "Instalacion": ejecutables
instalar xampp
instalar composer
	opcion añadir php al path (la ruta del php de xampp)

### Guia de "Instalacion": cmd

composer install
composer update
composer global require "laravel/installer"
copy .env.example .env
	crear la bd desde phpmyadmin y meterle el nombre en .env
php artisan key:generate
	sobre la carpeta principal del proyecto
php artisan migrate
	sobre la carpeta principal del proyecto

### Guia de "Instalacion": paths rapidos para probar
	http://127.0.0.1:8000
	http://127.0.0.1:8000/writeJSON
	http://127.0.0.1:8000/readJSON
	http://127.0.0.1:8000/test
	
	test sin artisan levantado
		http://127.0.0.1/SCADA/public/readJSON

### Instalacion Vue.JS (run once)
source: https://www.techiediaries.com/laravel/how-to-install-vuejs-in-laravel-6-7-by-example/
- composer require laravel/ui
- npm install 
	npm audit fix (breakes somethig, skipped)
- php artisan ui vue


npm install vue bootstrap-vue bootstrap

npm install vue-chartjs chart.js --save


registraciones de componentes de Vue
	https://michaelnthiessen.com/solve-unknown-custom-element-vue/
docs vue + bootstrap
	https://bootstrap-vue.org/docs
guia vue + chart js (ya ni recuerdo si la llegue a usar)
	https://vue-chartjs.org/guide/#chart-with-dynamic-styles
guia vue + chart js (posta)
	https://www.positronx.io/create-awesome-charts-in-vue-js-with-chart-js-and-vue-chartjs/


Laravel + Chart.js: Live-Chart with Refresh Every Second
	https://www.youtube.com/watch?v=dXeFrHo5HTM




	

<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400"></a></p>

<p align="center">
<a href="https://travis-ci.org/laravel/framework"><img src="https://travis-ci.org/laravel/framework.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains over 1500 video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the Laravel [Patreon page](https://patreon.com/taylorotwell).

### Premium Partners

- **[Vehikl](https://vehikl.com/)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Cubet Techno Labs](https://cubettech.com)**
- **[Cyber-Duck](https://cyber-duck.co.uk)**
- **[Many](https://www.many.co.uk)**
- **[Webdock, Fast VPS Hosting](https://www.webdock.io/en)**
- **[DevSquad](https://devsquad.com)**
- **[OP.GG](https://op.gg)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).




