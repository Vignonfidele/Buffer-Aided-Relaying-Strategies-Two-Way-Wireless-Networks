# Buffer-Aided-Relaying-Strategies-Two-Way-Wireless-Networks

# Abstract
The energy and time efficiency of wireless sensor networks (WSNs) is frequently affected by the low reliability of their links. To mitigate the outage probability, cooperation topologies are used. However, these topologies have particular challenges since the relay consumes energy in assisting a foreign communication, and the successful transmission in each direction is conditioned to the availability of the two segments involved in the communication. To overcome the temporary unavailability of a link, the use of buffers in the relay has been proposed, but energy and time efficiency remain a challenge for basic configurations. We propose two-way buffer-aided relaying strategies that exploit the presence of buffers in the different nodes that participate in the communication, as well as the efficient use of buffer capacity. The proposed strategies make the decision to forward the messages in one of the communication directions or broadcast coded messages based on buffer and channel state information. Firstly, we evaluate the impact of considering the use of buffers in the transmitter nodes. Then, we propose and evaluate the impact of the full and joint use of the entire buffer capacity to assist communication in both directions. Finally, we evaluate the performance of a system that exploits both the use of full and joint buffering and the presence of buffering in the transmitter. The results show that better performance, in terms of outage probability, is obtained by the third strategy; since it allows the buffer capacity to be exploited to a greater extent in the most urgent direction at each moment, as well as to select the start of each transmission to a viable communication opportunity. This represents a notable benefit in terms of energy and time efficiency for WSNs since unnecessary transmission of information is avoided, the number of idle slots decreases, and the amount of information per unit of time and energy increases.

 # System Model 
 ![Model_system](https://user-images.githubusercontent.com/110578891/193143062-4ec7e8f0-2557-4f36-8bb2-4c3090d177fd.jpg)
 
  *We consider a Two-Way-Relay system that can have buffers in all nodes as shown in Figure. The network is composed of three nodes: the sources* \\S_1\\, \\S_2\\ *and the relay* \\R\\. It is assumed that there is no direct link between \\ S_1\\  and  \\S_2\\ , then the nodes \\ S_1 \\ and \\ S_2 \\ communicate with each other via the relay node \\R\\.  All nodes are equipped with an omnidirectional antenna and \\ R \\ operates in half-duplex mode with the decode-and-forward protocol  . All the channels involved are independent and identically distributed (iid) with non-frequency-selective Rayleigh-block fading and additive white Gaussian noise (AWGN). We also consider the channels to be symmetrical. 
The channel response between transmitter \\i\\ and receiver \\j\\ is denoted \\ h_{ij} \\ where \\ \{ij\} \subset \{S_ {1}, S_ {2}, R \} \, \mid \, i \neq j\\. The {channel average power gain} is given by \\ \lambda_{ij} = d_{ij} ^ {-\alpha}\\, where \\ \alpha \\ is the path loss exponent and \\ d_{ij} \\ the normalized distance of the corresponding link with reference to \\S_1\\ and \\S_2\\.
