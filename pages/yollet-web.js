import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'
import '../public/main.dart'

export default function YolletWeb() {
    return (
        <div className={styles.container}>
            <iframe src="../public/main.dart" width="100%"></iframe>
        </div>
    )
}
