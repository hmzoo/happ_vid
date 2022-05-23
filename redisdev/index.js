const Redis = require("ioredis");

//const delay = 86400000;
const delay = 10000;
ranUKey = () => { return ranKey = "U" + ( Math.floor(Math.random() * 10)); }
checkUKey = (UKey) => {
    return redis.exists(UKey).then(exists => { 
        console.log(UKey+' exist?', (exists === 1));
        if(exists){
             return getUKey(UKey).then((data)=>{ console.log("Delta:"+(Date.now()-data.date));return Date.now()-data.date<delay})
        }else{
            return false;
        }
     });
}

findFreeUKey= (n) => {
    if(n>5){ return "ERROR";}
    n=n+1;
    k = ranUKey();
    console.log("TEST KEY ",k,n);
    return checkUKey(k).then(exists =>{if (!exists){ return k;}else { return findFreeUKey(n);} })
}


//ranUKey = () => { return ranKey = "U" + (10000 + Math.floor(Math.random() * 90000)); }

setUKey = (UKey) => {
    console.log("SET UKEY",UKey)
    return redis.hset(UKey, { info: "OK", date: Date.now()})
             .then(r =>{ return { ukey:UKey , msg: "SERVER READY"}});
}

getUKey = (UKey) => {
    return redis.hgetall(UKey);
}

newUKey = () => { 
    return findFreeUKey(0).then(key => { 
    if (key == "ERROR" ){ 
        console.log("SERVER FULL");
        return {ukey: "error",msg: "SERVER FULL!"};
       }else{
           return setUKey(key)}
       });
    }



  //console.log(chekUKey("U23"));

  //redis.exists("counter").then(exists => {redis.quit();console.log(exists)}).catch(err => console.log(err));

  const redis = new Redis();
  //addUKey("OKETO2").then(result => {redis.quit();console.log(result)}).catch(err =>{redis.quit();console.log(err)});
  //setUKey("OKETO").then(result => {redis.quit();console.log(result)}).catch(err => console.log(err));
 //checkUKey("OKETO").then(r => {redis.quit();console.log("FREE?",r)});
newUKey().then(data => {console.log(data);redis.quit()});
           