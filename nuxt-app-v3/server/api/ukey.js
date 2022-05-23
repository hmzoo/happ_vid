import Redis from "ioredis"
import { v4 as uuidv4 } from 'uuid';





const delay = 10000;
const ranUKey = () => { return  "U" + ( Math.floor(Math.random() * 10)); }



const findFreeUKey= (n) => {
    if(n>5){ return "ERROR";}
    n=n+1;
    let k = ranUKey();
    
    return isFreeUKey(k).then(exists =>{if (!exists){ return k;}else { return findFreeUKey(n);} })
}


//ranUKey = () => { return ranKey = "U" + (10000 + Math.floor(Math.random() * 90000)); }

const isFreeUKey = (UKey) => {
    const redis = new Redis();
    return redis.exists(UKey).then(exists => { 
        
        redis.quit();
        if(exists){
             return getUKey(UKey,"xxx").then((data)=>{ console.log("Delta:"+(Date.now()-data.date));return Date.now()-data.date<delay})
        }else{
            return false;
        }
     });
}

const initUKey = (UKey) => {
    
    const uid = uuidv4();
    const redis = new Redis();
    return redis.hset(UKey, { ukey:UKey,uid:uid,info: "OK", date: Date.now()})
             .then(r =>{ redis.quit();return { uid:uid,ukey:UKey , msg: "SERVER READY"}});
}

const getUKey = (UKey,uid) => {
    const redis = new Redis();
    return redis.hgetall(UKey).then(data =>{ 
        console.log("GETK",UKey,uid,data)
        redis.quit();
        if(data.uid == null || data.uid == uid ){
           return data; 
        }else{
            return { ukey:data.ukey,info:data.info, date:data.date}
        }
    });
}

const setUKey = (UKey,data) => {
    const redis = new Redis();
    return redis.hset(UKey, data)
             .then(r =>{ redis.quit();return data});
}

const newUKey = () => { 
    return findFreeUKey(0).then(key => { 
    if (key == "ERROR" ){ 
        console.log("SERVER FULL");
        return {err: "SERVER FULL!"};
       }else{
           return initUKey(key)}
       });
    }

const checkUKey= (ukey,uid)=>{
    console.log("CHECK",ukey,uid)
    return getUKey(ukey,uid).then(data=>{ 
        if(data.uid != null && data.uid == uid){
            data.date = Date.now();
            return setUKey(ukey,data)
        }else{
            return newUKey()
        }
    });

}


    
    export default defineEventHandler((event) => {
        const query = useQuery(event);
        return checkUKey(query.ukey,query.uid).then(data => { 
            return data;});
      })
      
