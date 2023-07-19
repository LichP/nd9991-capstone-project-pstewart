@extends('layouts.page')

@section('title')
    Welcome {{ $name }}!
@endsection

@section('content')
    <article>
        <h1>Welcome, {{ $name }}!</h1>
        <p>
            Welcome to this demo app, {{ $name }}! We hope you're having a great day.
        </p>
        <h2>Version</h2>
        <p><strong>1</strong></p>
    </article>
@endsection
