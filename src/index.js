import React, { FC } from "react";
import { processColor } from "react-native";
import type { Props } from "./RadialGradientNativeComponent";

const RNRadialGradientView = require("./RadialGradientNativeComponent").default;

const RadialGradient: FC<Props> = ({ colors, ...rest }) => {
  return (
    <RNRadialGradientView
      {...rest}
      colors={colors ? colors.map(processColor) : null}
    />
  );
};

export default RadialGradient;
