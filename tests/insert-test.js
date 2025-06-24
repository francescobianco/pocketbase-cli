
import PocketBase from 'pocketbase';

const pb = new PocketBase('http://localhost:8888');

const userData = await pb.collection('_superusers').authWithPassword('demo@javanile.org', 'Demo1234');

console.log(userData)

const newRecord = await pb.collection('Test').create({
    test: 'Lorem ipsum dolor sit amet',
});

console.log(newRecord)
