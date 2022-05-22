import Redis from "ioredis"




  getANewNumber = () => {
    const redis = new Redis()

    let ran = "U"+(10000+Math.floor(Math.random() * 90000));
    redis.exists('myKey').then( exists => { console.log('Does it exist?', (exists === 1)) }

  }


  export default defineEventHandler((event) => {
    
    let ran = 10000+Math.floor(Math.random() * 90000);

    return {
      number: ran
    }
  })