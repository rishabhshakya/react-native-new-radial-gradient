# react-native-new-radial-gradient

A `<RadialGradient>` element for React Native above 0.68.

> **Warning**: This Package is only for New Architecture.

## Installation

Using Yarn

```sh
yarn add react-native-new-radial-gradient
```

Using npm

```sh
npm install react-native-new-radial-gradient --save
```

### With React Native >= 0.60

Run `npx pod-install`

## Usage

```javascript
import RadialGradient from 'react-native-new-radial-gradient';

// TODO: What to do with the module?
<RadialGradient style={{width:200,height:200}}
                        colors={['black','green','blue','red']}
                        stops={[0.1,0.4,0.3,0.75]}
                        center={[100,100]}
                        radius={200}>
          {child elements}
</RadialGradient>
```

## Props

#### colors

An array of at least one color value. Color can be represented using string(i.e 'red', 'blue', 'black' etc.) or in #RRGGBB format.

#### center

An optional array of float value. If provided, it must contain x and y coordinate of the center of the gradient.
If nothing is provided then the center of the gradient will be at the middle of the element.

#### radius

A float value of the radius of the radial gradient. By default it is <code> min(width/2,height/2)</code>

#### stops

An optional array of numbers defining the location of each gradient color stop.
The relative position of each corresponding color is in the colors array.
Valid values are between <code>0.0f</code> and <code>1.0f</code>.
Example: [0.1, 0.75, 1] means that first color will take 0% - 10%, second color will take 10% - 75% and finally third color will occupy 75% - 100%. By default all color will be distributed evenly.
