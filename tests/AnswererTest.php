<?php

namespace Andreu\GithubActionsCiTest;

use Andreu\GithubActionsCi\Answerer;
use PHPUnit\Framework\TestCase;

final class AnswererTest extends TestCase
{
    private $answerer;
    private $greeting;

    protected function tearDown(): void
    {
        parent::tearDown();

        $this->answerer = null;
        $this->greeting = null;
    }

    public function testShouldSayHelloWhenGreeting()
    {
        $this->givenAnswerer();

        $this->whenItGreets();

        $this->thenItShouldSayAndreu();
    }

    private function givenAnswerer(): void
    {
        $this->answerer = new Answerer("Andreu");
    }

    private function whenItGreets(): void
    {
        $this->greeting = $this->answerer->greet();
    }

    private function thenItShouldSayAndreu(): void
    {
        $this->assertEquals("Hello Andreu", $this->greeting);
    }
}