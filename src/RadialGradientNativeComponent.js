// @flow
import type { ViewProps } from "react-native/Libraries/Components/View/ViewPropTypes";
import type { HostComponent } from "react-native";
import codegenNativeComponent from "react-native/Libraries/Utilities/codegenNativeComponent";
import type { Float } from "react-native/Libraries/Types/CodegenTypes";
import type { ColorValue } from "react-native/Libraries/StyleSheet/StyleSheet";

type NativeProps = $ReadOnly<{|
  ...ViewProps,
  colors: $ReadOnlyArray<ColorValue>,
  center?: $ReadOnlyArray<Float>,
  stops?: $ReadOnlyArray<Float>,
  radius?: Float,
  // add other props here
|}>;

export default (codegenNativeComponent<NativeProps>(
  "RadialGradientView"
): HostComponent<NativeProps>);
