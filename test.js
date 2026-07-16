const M1_LR = 0.4122214708,
  M1_LG = 0.5363325363,
  M1_LB = 0.0514459929;
const M1_MR = 0.2119034982,
  M1_MG = 0.6806995451,
  M1_MB = 0.1073969566;
const M1_SR = 0.0883024619,
  M1_SG = 0.2817188376,
  M1_SB = 0.6299787005;
const M2_L_L = 0.2104542553,
  M2_M_L = 0.793617785,
  M2_S_L = -0.0040720468;
const M2_L_A = 1.9779984951,
  M2_M_A = -2.428592205,
  M2_S_A = 0.4505937099;
const M2_L_B = 0.0259040371,
  M2_M_B = 0.7827717662,
  M2_S_B = -0.808675766;
const M2I_A_L = 0.3963377774,
  M2I_B_L = 0.2158037573;
const M2I_A_M = -0.1055613458,
  M2I_B_M = -0.0638541728;
const M2I_A_S = -0.0894841775,
  M2I_B_S = -1.291485548;
const M1I_L_R = 4.0767416613,
  M1I_M_R = -3.3077115904,
  M1I_S_R = 0.2309699287;
const M1I_L_G = -1.2684380041,
  M1I_M_G = 2.6097574007,
  M1I_S_G = -0.3413193963;
const M1I_L_B = -0.0041960865,
  M1I_M_B = -0.7034186145,
  M1I_S_B = 1.7076147009;

function srgbToLinear(c) {
  const abs = Math.abs(c);
  const linear = abs <= 0.04045 ? abs / 12.92 : ((abs + 0.055) / 1.055) ** 2.4;
  return c < 0 ? -linear : linear;
}
function srgbFromLinear(n) {
  const abs = Math.abs(n);
  const encoded =
    abs <= 0.0031308 ? 12.92 * abs : 1.055 * abs ** (1 / 2.4) - 0.055;
  return n < 0 ? -encoded : encoded;
}

function rgbToOklab([r, g, b]) {
  return linearSrgbToOklab(
    srgbToLinear(r / 255),
    srgbToLinear(g / 255),
    srgbToLinear(b / 255),
  );
}

function linearSrgbToOklab(lr, lg, lb) {
  const lv = Math.cbrt(M1_LR * lr + M1_LG * lg + M1_LB * lb);
  const mv = Math.cbrt(M1_MR * lr + M1_MG * lg + M1_MB * lb);
  const sv = Math.cbrt(M1_SR * lr + M1_SG * lg + M1_SB * lb);
  return [
    M2_L_L * lv + M2_M_L * mv + M2_S_L * sv,
    M2_L_A * lv + M2_M_A * mv + M2_S_A * sv,
    M2_L_B * lv + M2_M_B * mv + M2_S_B * sv,
  ];
}

function clamp(x, min, max) {
  return Math.min(max, Math.max(min, x));
}

function oklabToRgb([l, a, b]) {
  if (a === 0 && b === 0) {
    const v = l ** 3;
    const srgb = srgbFromLinear(clamp(v, 0, 1)) * 255;
    return clampRgb({ r: srgb, g: srgb, b: srgb, alpha });
  }

  const l_ = l + 0.3963377774 * a + 0.2158037573 * b;
  const m_ = l - 0.1055613458 * a - 0.0638541728 * b;
  const s_ = l - 0.0894841775 * a - 1.291485548 * b;

  const lv = l_ ** 3;
  const mv = m_ ** 3;
  const sv = s_ ** 3;

  const r = 4.0767416613 * lv - 3.3077115904 * mv + 0.2309699287 * sv;
  const g = -1.2684380041 * lv + 2.6097574007 * mv - 0.3413193963 * sv;
  const bv = -0.0041960865 * lv - 0.7034186145 * mv + 1.7076147009 * sv;

  return [
    srgbFromLinear(clamp(r, 0, 1)) * 255,
    srgbFromLinear(clamp(g, 0, 1)) * 255,
    srgbFromLinear(clamp(bv, 0, 1)) * 255,
  ];
}

console.log(oklabToRgb(rgbToOklab([18, 52, 86])));
