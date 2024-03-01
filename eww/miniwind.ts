// @ts-ignore
import * as fs from "fs";

///////////////
//   UTILS   //
///////////////
type ValueOf<T> = T[keyof T];
function objmap<
    T extends Record<string, unknown>,
    K2 extends string | number | symbol,
    V2
>(obj: T, map: (kv: [keyof T, T[keyof T]]) => [K2, V2]): Record<K2, V2> {
    return Object.fromEntries(
        Object.entries(obj).map(([k, v]) =>
            map([k as keyof T, v as T[keyof T]])
        )
    ) as Record<K2, V2>;
}

////////////////
//   CONFIG   //
////////////////
const config = {
    colors: {
        white: "#ffffff",
        black: "#000000",
        ok: {
            50: "#f0fdf4",
            100: "#dcfce7",
            200: "#bbf7d0",
            300: "#86efac",
            400: "#4ade80",
            500: "#22c55e",
            600: "#16a34a",
            700: "#15803d",
            800: "#166534",
            900: "#14532d"
        },
        notify: {
            50: "#eeeade",
            100: "#e9deca",
            200: "#e0ccae",
            300: "#e7c296",
            400: "#fba871",
            500: "#e4884c",
            600: "#cf7521",
            700: "#c76f1d",
            800: "#a55810",
            900: "#6d3c0f"
        },
        warn: {
            50: "#fff1f2",
            100: "#ffe4e6",
            200: "#fecdd3",
            300: "#fda4af",
            400: "#fb7185",
            500: "#f43f5e",
            600: "#e11d48",
            700: "#be123c",
            800: "#9f1239",
            900: "#881337"
        },
        gray: {
            50: "#f9fafb",
            100: "#f3f4f6",
            200: "#e5e7eb",
            300: "#d4e3ec",
            400: "#b2b2be",
            500: "#878791",
            600: "#767e86",
            700: "#5e6266",
            800: "#3d4044",
            900: "#1f2124"
        },
        pri: {
            50: "#f0f9ff",
            100: "#e0f2fe",
            200: "#bae6fd",
            300: "#7dd3fc",
            400: "#38bdf8",
            500: "#0ea5e9",
            600: "#0284c7",
            700: "#0369a1",
            800: "#075985",
            900: "#0c4a6e"
        }
    },
    text: {
        sizes: {
            xs: 12,
            sm: 14,
            base: 16,
            lg: 18,
            xl: 20,
            "2xl": 24,
            "3xl": 30,
            "4xl": 36,
            "5xl": 48,
            "6xl": 60,
            "7xl": 72,
            "8xl": 96,
            "9xl": 128
        }
    },
    rounded: {
        none: 0,
        sm: 2,
        bs: 4,
        md: 6,
        lg: 8,
        xl: 12,
        "2xl": 16,
        "3xl": 24,
        full: 9999
    },
    minSize: {
        h: {
            4: 16,
            5: 20,
            6: 24,
            7: 28,
            8: 32
        },
        w: {
            4: 16,
            5: 20,
            6: 24,
            7: 28,
            8: 32
        }
    },
    font: {
        weight: {
            thin: 100,
            extralight: 200,
            light: 300,
            normal: 400,
            medium: 500,
            semibold: 600,
            bold: 700,
            extrabold: 800,
            black: 900
        },
        family: {
            sans: ['"Quicksand"', "sans-serif"],
            mono: ['"jetbrains mono"', '"Courier New"', "Courier", "monospace"],
            icon: ["'Inter Nerd Font', Consolas, 'Courier New', monospace"]
        }
    },
    bg: {
        repeat: {
            norepeat: "no-repeat"
        },
        size: {}
    },
    sizes: {
        0: 0,
        px: 1,
        0.5: 2,
        1: 4,
        1.5: 6,
        2: 8,
        2.5: 10,
        3: 12,
        3.5: 14,
        4: 16,
        5: 20,
        6: 24,
        7: 28,
        8: 32,
        9: 36,
        10: 40,
        11: 44,
        12: 48,
        14: 56,
        16: 64,
        20: 80,
        24: 96,
        28: 112,
        32: 128,
        36: 144,
        40: 160,
        44: 176,
        48: 192,
        52: 208,
        56: 224,
        60: 240,
        64: 256,
        72: 288,
        80: 320,
        96: 384
    }
} as const;

type Styler = {
    $arb?: (str: string, clarifier: string) => string[] | string | undefined;
    $_?: (str: string) => string[] | string | undefined;
    $?: {
        [key: string]: string[] | string | Styler;
    };
};

type ClassToValue = [string | number, string][];
const configAsClassToValue = (
    conf: Record<string | number, string | number>
): ClassToValue => {
    return Object.entries(conf).map(([str, val]) => [
        str,
        typeof val === "string" ? val : val + "px"
    ]);
};

const gen = <T extends string | string[], C extends ClassToValue>(
    props: T,
    classToValue: C
): { [K in C[number][0]]: T } => {
    const value = (v: string) => {
        if (typeof props === "string") {
            return `${props}: ${v}`;
        } else {
            return props.map((prop) => `${prop}: ${v}`);
        }
    };

    const sizeobj: Record<string, string | string[]> = {};
    for (const c2v of classToValue) {
        sizeobj[c2v[0].toString()] = value(c2v[1]);
    }
    return sizeobj as { [K in C[number][0]]: T };
};
const genCols = (prop: string) =>
    objmap(
        config.colors,
        ([k, v]): [string, ValueOf<NonNullable<Styler["$"]>>] => {
            if (typeof v === "string") {
                return [k.toString(), `${prop}: ${v}`];
            } else {
                return [
                    k.toString(),
                    {
                        $: gen(prop, Object.entries(v))
                    }
                ];
            }
        }
    );

const styler: Styler = {
    $: {
        bg: {
            $arb: (arb: string) => `background-color: ${arb}`,
            $: {
                ...genCols("background-color"),
                ...gen(
                    "background-repeat",
                    configAsClassToValue(config.bg.repeat)
                ),
                ...gen("background-size", configAsClassToValue(config.bg.size)),
                size: {
                    $arb: (arb: string) => `background-size: ${arb}`
                }
            }
        },
        text: {
            $: {
                ...gen("font-size", configAsClassToValue(config.text.sizes)),
                ...genCols("color")
            },
            $arb(str, clarifier) {
                if (clarifier) {
                    if (clarifier === "color") {
                        return `color: ${str}`;
                    } else if (clarifier === "length") {
                        return `font-size: ${str}`;
                    } else {
                        console.warn("Unknown clarifier: `" + clarifier + "`");
                    }
                }

                if (str[0] === "#" || str.startsWith("rgb")) {
                    return `color: ${str}`;
                }
                if (str.endsWith("px")) {
                    return `font-size: ${str}`;
                }
                console.warn("Unknown text style: `" + str + "`");
            }
        },
        font: {
            $: {
                ...gen(
                    "font-weight",
                    Object.entries(config.font.weight).map(([k, v]) => [
                        k,
                        v.toString()
                    ])
                ),
                ...gen(
                    "font-family",
                    Object.entries(config.font.family).map(([k, v]) => [
                        k,
                        v.join(", ")
                    ])
                )
            }
        },
        rounded: {
            $arb: (arb: string) => `border-radius: ${arb}`,
            $: {
                l: {
                    $arb: (arb: string) => [
                        `border-top-left-radius: ${arb}`,
                        `border-bottom-left-radius: ${arb}`
                    ],
                    $: gen(
                        ["border-top-left-radius", "border-bottom-left-radius"],
                        configAsClassToValue(config.rounded)
                    )
                },
                r: {
                    $arb: (arb: string) => [
                        `border-top-right-radius: ${arb}`,
                        `border-bottom-right-radius: ${arb}`
                    ],
                    $: gen(
                        [
                            "border-top-right-radius",
                            "border-bottom-right-radius"
                        ],
                        configAsClassToValue(config.rounded)
                    )
                },
                t: {
                    $arb: (arb: string) => [
                        `border-top-left-radius: ${arb}`,
                        `border-top-right-radius: ${arb}`
                    ],
                    $: gen(
                        ["border-top-left-radius", "border-top-right-radius"],
                        configAsClassToValue(config.rounded)
                    )
                },
                b: {
                    $arb: (arb: string) => [
                        `border-bottom-left-radius: ${arb}`,
                        `border-bottom-right-radius: ${arb}`
                    ],
                    $: gen(
                        [
                            "border-bottom-left-radius",
                            "border-bottom-right-radius"
                        ],
                        configAsClassToValue(config.rounded)
                    )
                },
                tl: {
                    $arb: (arb: string) => `border-top-left-radius: ${arb}`,
                    $: gen(
                        "border-top-left-radius",
                        configAsClassToValue(config.rounded)
                    )
                },
                tr: {
                    $arb: (arb: string) => `border-top-right-radius: ${arb}`,
                    $: gen(
                        "border-top-right-radius",
                        configAsClassToValue(config.rounded)
                    )
                },
                bl: {
                    $arb: (arb: string) => `border-bottom-left-radius: ${arb}`,
                    $: gen(
                        "border-bottom-left-radius",
                        configAsClassToValue(config.rounded)
                    )
                },
                br: {
                    $arb: (arb: string) => `border-bottom-right-radius: ${arb}`,
                    $: gen(
                        "border-bottom-right-radius",
                        configAsClassToValue(config.rounded)
                    )
                },
                ...gen("border-radius", configAsClassToValue(config.rounded))
            }
        },
        min: {
            $: {
                h: {
                    $arb: (arb: string) => `min-height: ${arb}`,
                    $: gen("min-height", configAsClassToValue(config.minSize.h))
                },
                w: {
                    $arb: (arb: string) => `min-width: ${arb}`,
                    $: gen("min-width", configAsClassToValue(config.minSize.w))
                }
            }
        },
        p: {
            $: {
                ...gen("padding", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `padding: ${arb}`
        },
        px: {
            $: {
                ...gen(
                    ["padding-left", "padding-right"],
                    configAsClassToValue(config.sizes)
                )
            },
            $arb: (arb: string) => [
                `padding-left: ${arb}`,
                `padding-right: ${arb}`
            ]
        },
        py: {
            $: {
                ...gen(
                    ["padding-top", "padding-bottom"],
                    configAsClassToValue(config.sizes)
                )
            },
            $arb: (arb: string) => [
                `padding-top: ${arb}`,
                `padding-bottom: ${arb}`
            ]
        },
        pt: {
            $: {
                ...gen("padding-top", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `padding-top: ${arb}`
        },
        pr: {
            $: {
                ...gen("padding-right", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `padding-right: ${arb}`
        },
        pb: {
            $: {
                ...gen("padding-bottom", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `padding-bottom: ${arb}`
        },
        pl: {
            $: {
                ...gen("padding-left", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `padding-left: ${arb}`
        },
        m: {
            $: {
                ...gen("margin", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `margin: ${arb}`
        },
        mx: {
            $: {
                ...gen(
                    ["margin-left", "margin-right"],
                    configAsClassToValue(config.sizes)
                )
            },
            $arb: (arb: string) => [
                `margin-left: ${arb}`,
                `margin-right: ${arb}`
            ]
        },
        my: {
            $: {
                ...gen(
                    ["margin-top", "margin-bottom"],
                    configAsClassToValue(config.sizes)
                )
            },
            $arb: (arb: string) => [
                `margin-top: ${arb}`,
                `margin-bottom: ${arb}`
            ]
        },
        mt: {
            $: {
                ...gen("margin-top", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `margin-top: ${arb}`
        },
        mr: {
            $: {
                ...gen("margin-right", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `margin-right: ${arb}`
        },
        mb: {
            $: {
                ...gen("margin-bottom", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `margin-bottom: ${arb}`
        },
        ml: {
            $: {
                ...gen("margin-left", configAsClassToValue(config.sizes))
            },
            $arb: (arb: string) => `margin-left: ${arb}`
        }
    }
};

function miniwind(className_: string): string[] {
    let className = className_;
    let style = styler;
    while (className) {
        const arbMatch = className.match(/^\[((.+):)?(.+)\]$/);
        if (arbMatch) {
            const arb = arbMatch[3];
            if (style.$arb) {
                const styled = style.$arb(arb, arbMatch[2]);
                if (styled) {
                    return Array.isArray(styled) ? styled : [styled];
                } else {
                    console.warn("Class name not processable:", className_);
                    return [];
                }
            }
        }

        // Try find the class name in the style object
        const [c] = className.split("-", 1);
        className = className.slice(c.length + 1);
        let foundSomething = false;
        if (style.$) {
            let newStyle = style.$[c];
            if (newStyle) {
                if (typeof newStyle === "string") {
                    if (className) {
                        console.warn("Class name not found:", className_);
                        return [];
                    }
                    return [newStyle];
                } else if (Array.isArray(newStyle)) {
                    if (className) {
                        console.warn("Class name not found:", className_);
                        return [];
                    }
                    return newStyle;
                } else {
                    style = newStyle;
                    foundSomething = true;
                }
            }
        }

        if (!foundSomething) {
            // Try in the default fn
            if (style.$_) {
                const styled = style.$_(c);
                if (styled) {
                    return Array.isArray(styled) ? styled : [styled];
                } else {
                    console.warn("Class name not processable:", className_);
                    return [];
                }
            }

            console.warn("Class name not found:", className_);
            return [];
        }
    }

    console.warn("Class name not found:", className_);
    return [];
}

function main() {
    // Read in the `tw.scss` file to a string
    const tw: string = fs.readFileSync("tw.scss", "utf8");

    // Find all instances of `@apply` and match them up until a semicolon
    let output = "";
    let remaining = tw;
    let match;
    // Loop through all the matches
    while ((match = remaining.match(/^([^/\n]*)(@apply ([^;]+);)(.*)/m))) {
        // Add all text from the previous match to the current match
        output += remaining.slice(0, match.index! + match[1].length);
        remaining = remaining.slice(match.index! + match[1].length + match[2].length);

        // Get the matched class names
        const classes = match[3].split(" ");

        // Loop through all the class names
        for (const className of classes) {
            output += " /* " + className + " */ ";
            for (const style of miniwind(className)) {
                output += style + ";";
            }
        }
    }
    // Add all text from the final match to the end
    output += remaining;

    // Output it to the `tw.css` file
    fs.writeFileSync("eww.scss", output);
}

main();
