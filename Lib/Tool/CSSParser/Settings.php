<?php

class Settings {
    /**
     * Multi-byte string support. If true (default), will use (slower) mb_strlen, mb_convert_case, mb_substr and mb_strpos functions. Otherwise, the normal (ASCII-Only) functions will be used.
     */
    public $bMultibyteSupport = true;

    /**
     * The default charset for the CSS if no `@charset` rule is found. Defaults to utf-8.
     */
    public $sDefaultCharset = 'utf-8';

    /**
     * Lenient parsing. When used, the parser will not choke on unexpected tokens but simply ignore them.
     */
    public $bLenientParsing = true;

    private function __construct() {}

    public static function create() {
        return new Settings();
    }

    public function withMultibyteSupport($bMultibyteSupport = true) {
        $this->bMultibyteSupport = $bMultibyteSupport;
        return $this;
    }

    public function withDefaultCharset($sDefaultCharset) {
        $this->sDefaultCharset = $sDefaultCharset;
        return $this;
    }

    public function withLenientParsing($bLenientParsing = true) {
        $this->bLenientParsing = $bLenientParsing;
        return $this;
    }

    public function beStrict() {
        return $this->withLenientParsing(false);
    }
}