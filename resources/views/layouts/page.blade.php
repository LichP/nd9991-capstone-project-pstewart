@push('head')
    @vite(['resources/css/app.css'])
@endpush

<!DOCTYPE html>
<html class="no-js" lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        @hasSection('title')
            <title>@yield('title') | Welcome Demo App</title>
        @else
            <title>Welcome Demo App</title>
        @endif
        @stack('head')
    </head>
    <body>
        @yield('content')
    </body>
</html>
