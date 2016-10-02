


function getMemcacheKeys() {
    $memcache = new Memcache;
    $memcache->connect('127.0.0.1', 11211) 
       or die ("Could not connect to memcache server");

    $list = array();
    $allSlabs = $memcache->getExtendedStats('slabs');
    $items = $memcache->getExtendedStats('items');
    foreach($allSlabs as $server => $slabs) {
        foreach($slabs AS $slabId => $slabMeta) {
            $cdump = $memcache->getExtendedStats('cachedump',(int)$slabId);
            foreach($cdump AS $keys => $arrVal) {
                if (!is_array($arrVal)) continue;
                foreach($arrVal AS $k => $v) {                   
                    echo $k .'<br>';
                }
            }
        }
    }   
} 
