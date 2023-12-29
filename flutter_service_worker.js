'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "cb144b52fe7c0da418339d5b626b5474",
"index.html": "c38d2945cc8167ec6b1c5449b47e62f7",
"/": "c38d2945cc8167ec6b1c5449b47e62f7",
"main.dart.js": "efddfc9948e2213301f0289fad4e7f48",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "13ec3afdd6ce4e19838f8283412ee4c1",
"icons/Icon-192.png": "f8a609a995f13600fa916e57562c693e",
"icons/Icon-512.png": "7d80e4606a3a2f3191ba4da5642f9d75",
"manifest.json": "6eb45073266a3e794d990593e0a60ac3",
"index1.html": "13196af40fbe22e31a664b544aedec0d",
"assets/AssetManifest.json": "b0ca12cbdbd75df90b8012cfb9d301c7",
"assets/NOTICES": "acbda0779678d363316bfd9daca2d636",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/packages/window_manager/images/ic_chrome_unmaximize.png": "4a90c1909cb74e8f0d35794e2f61d8bf",
"assets/packages/window_manager/images/ic_chrome_minimize.png": "4282cd84cb36edf2efb950ad9269ca62",
"assets/packages/window_manager/images/ic_chrome_maximize.png": "af7499d7657c8b69d23b85156b60298c",
"assets/packages/window_manager/images/ic_chrome_close.png": "75f4b8ab3608a05461a31fc18d6b47c2",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "a6b62d9739fecd714588b087e0f87f66",
"assets/fonts/MaterialIcons-Regular.otf": "fd66386a8bf65858b5bf88643dfc798d",
"assets/assets/images/pp_icon_left_back.png": "5a651fa68c6ce3067381e128e6e55642",
"assets/assets/images/pp_ban_zfb_logo.png": "02e7735962a1bf4037ad9ec461544ccd",
"assets/assets/images/pp_icon_order_wait2.png": "936f9b473c0a879d7d1d46c69da8b534",
"assets/assets/images/pp_pay_appeal.png": "4858cd8cc21084500b5d69b1e7019526",
"assets/assets/images/pp_avatar.png": "5ff3c15d12c2ced3f35166f90496be24",
"assets/assets/images/pp_mine_list_8.png": "0a4e99513d7dfc5321cf8555b07a8155",
"assets/assets/images/pp_home_right_button2.png": "f94310c0195c6a046be5c8645f508894",
"assets/assets/images/pp_home_right_button.png": "cb2139f9f92b47d52fdbd6113abad426",
"assets/assets/images/pp_icon_filter.png": "f39208b1575f5b7a6f6b1c2b3087ec08",
"assets/assets/images/pp_mine_my_code.png": "62845906949b78f9be428c16671aa522",
"assets/assets/images/pp_home_card_logo.png": "94b2260a8a0a92cc95f3f19a2d54f064",
"assets/assets/images/pp_icon_order_wait1.png": "1c4d49d93d1b86e16faba1fa3570a61e",
"assets/assets/images/pp_home_button_receive.png": "7b656bd2c82ed93eea744339ea0a0984",
"assets/assets/images/pp_card_id.png": "4eaf0fe002417efb0dc796ac5077a6d6",
"assets/assets/images/pp_bg_sfz_hand.png": "24acbc35d2606373a6630e0baa42b57d",
"assets/assets/images/pp_bg_start.png": "d80959e5ed731823bd6b5693767da6d0",
"assets/assets/images/pp_upload_img.png": "476dbab9af9319bc635b4930317abdfe",
"assets/assets/images/pp_icon_selected.png": "4e52028ae1016e473d06c65e26dea9bb",
"assets/assets/images/pp_card_icon_zfb.png": "0d09c2bdfad1eeedc6a9ca54dc4ec480",
"assets/assets/images/pp_bank_weixin.png": "305f22a8a99a83997ad0836316a6d0d0",
"assets/assets/images/pp_right_arrow_home.png": "18cadd53e307d09d30a67def21159b8c",
"assets/assets/images/pp_icon_time_picker.png": "af5f92312ce88edfe8b0ee46c96df0b9",
"assets/assets/images/pp_pay_ok.png": "4f48ac9df933cb726d02de88eae60cea",
"assets/assets/images/pp_card_icon_wx.png": "2c929b1cc684e5fa95d1a3e364913c80",
"assets/assets/images/pp_icon_order_cancle.png": "05134ad17285ce678e69d6369f0f0a9a",
"assets/assets/images/pp_home_copy.png": "5facc97ea8a50bdf43c4f968872b5bbf",
"assets/assets/images/pp_icon_history.png": "197b06652dff38bdc2dc369193d3f556",
"assets/assets/images/pp_left_top_back.png": "3eaf331f9ada516ef14827f21d72971a",
"assets/assets/images/pp_app_start_3.webp": "59b566c7ffd70e02fa1a7741eb6ec070",
"assets/assets/images/pp_pwd_lock_icon_small_hint.png": "ab27402c6d0d4f01ce91bd4c27c258f8",
"assets/assets/images/pp_mine_icon_face.png": "c2d4c3fa4190a6e1026e0b32e97b808c",
"assets/assets/images/pp_update_head.png": "a9be1e784a065c52660887fbf281e5b6",
"assets/assets/images/pp_icon_hand.png": "ffc6f1e64b8a42a70e1cf3f6ed021644",
"assets/assets/images/pp_mine_close.png": "5694779d97284d1aaeee08745cbc816b",
"assets/assets/images/pp_bank_wx_logo.png": "8392855ffe49ac02af76fbf8929eaab9",
"assets/assets/images/pp_icon_type_lock.png": "0a22f6e98884c4c8067c850168b865f1",
"assets/assets/images/pp_bank_wx_white.png": "a6846a07d7928a3798733170085342b5",
"assets/assets/images/pp_bank_zfb_white.png": "1affab9a954593a9bc7a2ba1aa1814f5",
"assets/assets/images/pp_icon_money_check.png": "a23e0397037f5cf0cdd2802413e73edb",
"assets/assets/images/pp_bg_sfz_front.png": "0cc8d6c20ec783e5212ef7cae77da673",
"assets/assets/images/pp_card_icon_card.png": "ed1e278e9d5c763769b5ae0daf110b5e",
"assets/assets/images/pp_card_icon_wx_black.png": "c239f64836445813a607a4ab1396a030",
"assets/assets/images/pp_icon_gd.png": "418db6cb6a51d5503d323732fdec9e20",
"assets/assets/images/pp_app_start_2.webp": "2afa39926c33cb782f324cd882c1b9fc",
"assets/assets/images/pp_logo_circle.png": "13755e28dc67352a57c658a3bfc03b47",
"assets/assets/images/pp_home_button_send.png": "ae48c5acefae4b675c1aa468ba8db5f7",
"assets/assets/images/pp_home_icon_notice.png": "c2b7bbf569ef7b6f6970f98a7c858ac1",
"assets/assets/images/pp_pwd_lock_hint.png": "bbd7c685addfabcac1bff35e0d52f6ca",
"assets/assets/images/pp_app_start_1.webp": "db0fbb793bef9aee6514b874c568db2d",
"assets/assets/images/pp_mine_code.png": "62845906949b78f9be428c16671aa522",
"assets/assets/images/pp_bg_sfz_back.png": "587cd85d8fa48b6322d727f50c94ebe1",
"assets/assets/images/pp_home_avatar.png": "e2eab365e14da72fff85b95dd975f9d1",
"assets/assets/images/pp_mine_icon_number.png": "ca00ce1fffc825fa07f9abf01cfb2419",
"assets/assets/images/pp_mine_right_arrow.png": "c3e34f1cad5b79d6b73fb90d5322324e",
"assets/assets/images/pp_icon_contact.png": "4a1c56d5e60a61908d3ab2189b9f799f",
"assets/assets/images/pp_icon_selected_un.png": "eceaf5e8f82011b52800c69bf99acb43",
"assets/assets/images/pp_bank_card_white.png": "66d7197ed557c76973b33f8037e993d3",
"assets/assets/images/pp_icon_pate.png": "b86b1c6f675fda602a4721597e8ea18e",
"assets/assets/images/pp_hint_ask_orange.png": "97d3b8ccc82b3f892835e4ea4e2df703",
"assets/assets/images/pp_home_button_4.png": "e5a5f45af72f16fe87d382624b2b1664",
"assets/assets/images/pp_home_copy_grey.png": "babd34790d800c368a9f01a7af1fefda",
"assets/assets/images/pp_mine_list_1.png": "d0bc4250ce2740a1bb9e2d0c098baa52",
"assets/assets/images/pp_home_button_topup.png": "ba6f75b9e16ef3923626275f7d2b2141",
"assets/assets/images/pp_order_item_sell.png": "0405a96eadae110b0b8ac699dc81544f",
"assets/assets/images/pp_card_icon_zfb_black.png": "8b4ae2e5d568b5bb6c4fffd44ed48aac",
"assets/assets/images/pp_mine_list_3.png": "8526b0f9ce82d31bb0c5d114c0ef1cc2",
"assets/assets/images/pp_home_icon_hint.png": "d1ef6bfb0497d436ac9aac6c2db6f95b",
"assets/assets/images/pp_home_icon_red.png": "1254c6dee6c8a8fe3d5946b95428b89a",
"assets/assets/images/pp_card_icon_card_black.png": "30af7d7d83f34fa03a78ed3c28b08e58",
"assets/assets/images/pp_mine_icon_safety.png": "269d030ddb71b173b8c88162f7679f55",
"assets/assets/images/pp_mine_list_2.png": "3d78a46ac9ce7f911074af2dc947c8b0",
"assets/assets/images/pp_icon_scan.png": "4bf71a739848cdb6fef927f447e94db8",
"assets/assets/images/pp_success_mark.png": "ef6a7117d2853eec353010167575d547",
"assets/assets/images/pp_icon_add_bank.png": "859a81ac126f3c341c0d88686ad6b431",
"assets/assets/images/pp_head_img.png": "0475eb9ef8e2099a9d75f294983a57d9",
"assets/assets/images/pp_close_right.png": "62af7d064158a498fb81893493e24cce",
"assets/assets/images/pp_bank_zfb.png": "258d57050978c232cb7649e283ac5fa3",
"assets/assets/images/pp_mine_list_6.png": "03ddafcc2cf7308ae68ff5101adfd76b",
"assets/assets/images/pp_home_button_swap.png": "08384d06159f90975d56c87348d9cf92",
"assets/assets/images/pp_bank_bank.png": "84c9eab9aac5d12f3749518e0a79f339",
"assets/assets/images/pp_home_button_2.png": "577e385afffa1b682033497e26a3f9c9",
"assets/assets/images/pp_home_button_3.png": "d89a08403d6570c458d2370f35e77521",
"assets/assets/images/pp_mine_list_7.png": "46ea31e481db4d4c440a6b78f4219e07",
"assets/assets/images/pp_order_item_buy.png": "7c26641e70938da8141423a6303a727f",
"assets/assets/images/pp_mine_list_5.png": "e61d15f4a3cbc8e9b2c87122bd5b7233",
"assets/assets/images/pp_null_list.png": "44587983eeb0133704f6de64fb899b77",
"assets/assets/images/pp_hint_ask.png": "52354591a9665d34c5f7c68a12605ce1",
"assets/assets/images/pp_home_button_1.png": "d32a10ff8cfdb92e262bd64ec930b50a",
"assets/assets/images/pp_mine_list_4.png": "d2ca9d2a3aff4324a125145394b2ac6b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
