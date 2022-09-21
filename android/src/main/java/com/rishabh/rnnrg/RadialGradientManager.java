package com.rishabh.rnnrg;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewManagerDelegate;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.viewmanagers.RadialGradientViewManagerInterface;
import com.facebook.react.viewmanagers.RadialGradientViewManagerDelegate;


/**
 * Created by Surajit on 12/23/2017.
 */
@ReactModule(name = RadialGradientManager.NAME)
public class RadialGradientManager extends SimpleViewManager<RadialGradientView> 
    implements RadialGradientViewManagerInterface<RadialGradientView> {

    private final ViewManagerDelegate<RadialGradientView> mDelegate;

    static final String NAME = "RadialGradientView";

    public static final String PROP_COLORS = "colors";
    public static final String PROP_CENTER = "center";
    public static final String PROP_RADIUS = "radius";
    public static final String PROP_STOPS = "stops";

    public RadialGradientManager(ReactApplicationContext context) {
        mDelegate = new RadialGradientViewManagerDelegate<>(this);
    }

    @Nullable
    @Override
    protected ViewManagerDelegate<RadialGradientView> getDelegate() {
        return mDelegate;
    }

    @NonNull
    @Override
    public String getName() {
        return NAME;
    }

    @NonNull
    @Override
    protected RadialGradientView createViewInstance(@NonNull ThemedReactContext reactContext) {
        return new RadialGradientView(reactContext);
    }

    @Override
    @ReactProp(name=PROP_COLORS)
    public void setColors(RadialGradientView gradientView, @Nullable ReadableArray colors) {
        gradientView.setColors(colors);
    }

    @Override
    @ReactProp(name=PROP_CENTER)
    public void setCenter(RadialGradientView gradientView, @Nullable ReadableArray center) {
        gradientView.setCenter(center);
    }

    @Override
    @ReactProp(name=PROP_RADIUS)
    public void setRadius(RadialGradientView gradientView, @Nullable float radius) {
        gradientView.setRadius(radius);
    }

    @Override
    @ReactProp(name=PROP_STOPS)
    public void setStops(RadialGradientView gradientView, @Nullable ReadableArray stops) {
        gradientView.setStops(stops);
    }
}
