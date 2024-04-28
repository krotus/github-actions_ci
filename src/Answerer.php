<?php

namespace Andreu\GithubActionsCi;

final class Answerer
{
    private const string GREETING = "Hello";

    public function __construct(private string $name) {}

    public function name(): string
    {
        return $this->name;
    }

    public function greet(): string
    {
        return self::GREETING . ' ' . $this->name;
    }
}