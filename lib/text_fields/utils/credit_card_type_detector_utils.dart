
String detectarBandeira(String numeroCartao) {
  if (RegExp(r'^3841').hasMatch(numeroCartao) ||
      RegExp(r'^60').hasMatch(numeroCartao)) {
    return 'assets/assas/hipercard.png';
  } else if (numeroCartao.startsWith('4')) {
    return 'assets/assas/visa.png';
  } else if (numeroCartao.startsWith('5')) {
    return 'assets/assas/mastercard.png';
  } else if (numeroCartao.startsWith('34') || numeroCartao.startsWith('37')) {
    return 'assets/assas/amex.png';
  } else if (numeroCartao.startsWith('6')) {
    return 'assets/assas/discover.png';
  } else if (numeroCartao.startsWith('35')) {
    return 'assets/assas/jcb.png';
  } else if (numeroCartao.startsWith('37')) {
    return 'assets/assas/diners.png';
  }
  if (numeroCartao.startsWith('636368') ||
      numeroCartao.startsWith('438935') ||
      numeroCartao.startsWith('504175') ||
      numeroCartao.startsWith('451416') ||
      numeroCartao.startsWith('636297') ||
      numeroCartao.startsWith('5067') ||
      numeroCartao.startsWith('4576') ||
      numeroCartao.startsWith('4011') ||
      numeroCartao.startsWith('506699')) {
    return 'assets/assas/elo.png';
  } else {
    return '';
  }
}