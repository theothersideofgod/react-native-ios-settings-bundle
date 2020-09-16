import { NativeModules, Platform, NativeEventEmitter } from "react-native";

const { RNIosSettingsBundle } = NativeModules;

export const RNIosSettingsBundleEventEmitter = new NativeEventEmitter(
  RNIosSettingsBundle
);

export default {
  setBoolForKey: (key, value, callback) => {
    if (Platform == "android") return callback([1, "it works only on ios!"]);

    RNIosSettingsBundle.setBoolForKey(value, key, callback);
  },
  boolForKey: (key, callback) => {
    if (Platform == "android") return callback([1, "it works only on ios!"]);

    RNIosSettingsBundle.boolForKey(key, callback);
  },
};
