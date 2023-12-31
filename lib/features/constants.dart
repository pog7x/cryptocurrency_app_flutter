import 'package:flutter/material.dart';

import 'package:cryptocurrency_app/generated/l10n.dart';

const String currencyItemUSD = 'USD';
const String currencyItemEUR = 'EUR';
const String currencyItemJPY = 'JPY';

const String appThemeModeDark = 'Dark';
const String appThemeModeLight = 'Light';
const String appThemeModeSystem = 'System';

Map<String, String> appThemeModeMap = {
  appThemeModeDark: S.current.dark,
  appThemeModeLight: S.current.light,
  appThemeModeSystem: S.current.system,
};

String ctxAppThemeMode(BuildContext context, String mode) {
  Map<String, String> contextMap = {
    appThemeModeDark: S.of(context).dark,
    appThemeModeLight: S.of(context).light,
    appThemeModeSystem: S.of(context).system,
  };

  return contextMap[mode]!;
}

const userLocaleEN = 'en';
const userLocaleRU = 'ru';

Map<String, String> userLocaleMap = {
  userLocaleEN: 'English',
  userLocaleRU: 'Русский',
};

const allCryptoCoins = [
  'BTC',
  'ETH',
  'LTC',
  'BCH',
  'USDC',
  'USDT',
  'XRP',
  'SOL',
  'BUSD',
  'TUSD',
  'BNB',
  'ETC',
  'PEPE',
  'ADA',
  'ARB',
  'DOGE',
  'XEC',
  'MATIC',
  'EOS',
  'COMP',
  'LINK',
  'WAVES',
  'CFX',
  'XLM',
  'OP',
  'BSV',
  'AVAX',
  'DOT',
  'SHIB',
  'APT',
  'AAVE',
  'FIL',
  'TOMO',
  'TRX',
  'NEO',
  'FTM',
  'MKR',
  'GALA',
  'SUI',
  'VGX',
  'FTT',
  'STX',
  'UNI',
  'ATOM',
  'BTG',
  'ZEN',
  'SNX',
  'INJ',
  'NEAR',
  'QTUM',
  'APE',
  'VET',
  'MAGIC',
  'XMR',
  'MTL',
  'LDO',
  'KAVA',
  'CRV',
  'MASK',
  'RNDR',
  'DYDX',
  'ZEC',
  'BLUR',
  'SRM',
  'MANA',
  'STORJ',
  'REP',
  'AXS',
  'LINA',
  'CTC',
  'AGI',
  'ALGO',
  'FET',
  'SAND',
  'SXP',
  'LUNC',
  'ZIL',
  'RDNT',
  'GMT',
  'DASH',
  'GRT',
  'ARPA',
  'ID',
  'CHZ',
  'MDT',
  'ONT',
  'XVG',
  'CAKE',
  'CREAM',
  'HBAR',
  'ICP',
  'ANKR',
  'IMX',
  'AGLD',
  'RUNE',
  'WBTC',
  'FLOKI',
  'GAS',
  'SUSHI',
  'MLK'
];
