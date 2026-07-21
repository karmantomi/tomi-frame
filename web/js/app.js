// ====================================
// TOMI FRAMEWORK - MAIN APP
// ====================================

// NUI Message Handler
window.addEventListener('message', function(event) {
    let data = event.data;
    
    if (data.action == "updateHUD") {
        updateHUD(data.data);
    } else if (data.action == "openInventory") {
        openInventory(data.data);
    } else if (data.action == "openJobMenu") {
        openJobMenu();
    } else if (data.action == "openShop") {
        openShop(data.data);
    } else if (data.action == "openBank") {
        openBank();
    }
});

// ====================================
// HUD Functions
// ====================================

function updateHUD(playerData) {
    if (playerData) {
        document.getElementById('money').textContent = '$' + playerData.money.toLocaleString();
        document.getElementById('bank').textContent = '$' + playerData.bank.toLocaleString();
        document.getElementById('job').textContent = playerData.job || 'Munkanélküli';
        document.getElementById('health').textContent = playerData.health + '%' || '100%';
        document.getElementById('armor').textContent = playerData.armor + '%' || '0%';
    }
}

// ====================================
// Inventory Functions
// ====================================

function openInventory(inventory) {
    const modal = document.getElementById('inventory-modal');
    const grid = document.getElementById('inventory-grid');
    
    grid.innerHTML = '';
    
    if (inventory && Object.keys(inventory).length > 0) {
        for (const [item, count] of Object.entries(inventory)) {
            const itemDiv = document.createElement('div');
            itemDiv.className = 'inventory-item';
            itemDiv.innerHTML = `
                <span class="inventory-item-name">${item}</span>
                <span class="inventory-item-count">x${count}</span>
            `;
            grid.appendChild(itemDiv);
        }
    } else {
        grid.innerHTML = '<p style="color: #ff0000; grid-column: 1/-1; text-align: center;">Üres tárgy</p>';
    }
    
    modal.classList.remove('hidden');
}

// ====================================
// Job Menu Functions
// ====================================

function openJobMenu() {
    const modal = document.getElementById('job-modal');
    const list = document.getElementById('job-list');
    
    // Mock jobs data - in real scenario would come from server
    const jobs = {
        unemployed: { label: 'Munkanélküli', salary: 0 },
        police: { label: 'Rendőr', salary: 500 },
        mechanic: { label: 'Szerelő', salary: 300 },
        taxi: { label: 'Taxi Sofőr', salary: 200 },
        doctor: { label: 'Orvos', salary: 400 },
        dealer: { label: 'Kereskedő', salary: 250 }
    };
    
    list.innerHTML = '';
    
    for (const [jobId, jobData] of Object.entries(jobs)) {
        const jobDiv = document.createElement('div');
        jobDiv.className = 'job-item';
        jobDiv.innerHTML = `
            <div class="job-name">${jobData.label}</div>
            <div class="job-salary">Fizetés: $${jobData.salary}/óra</div>
        `;
        jobDiv.addEventListener('click', function() {
            setJob(jobId);
            modal.classList.add('hidden');
        });
        list.appendChild(jobDiv);
    }
    
    modal.classList.remove('hidden');
}

function setJob(job) {
    fetch(`https://${GetParentResourceName()}/setJob`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({job: job})
    });
}

// ====================================
// Bank Functions
// ====================================

function openBank() {
    const modal = document.getElementById('bank-modal');
    modal.classList.remove('hidden');
    
    document.getElementById('deposit-btn').onclick = function() {
        const amount = parseInt(document.getElementById('bank-amount').value);
        if (amount > 0) {
            depositMoney(amount);
            modal.classList.add('hidden');
        }
    };
    
    document.getElementById('withdraw-btn').onclick = function() {
        const amount = parseInt(document.getElementById('bank-amount').value);
        if (amount > 0) {
            withdrawMoney(amount);
            modal.classList.add('hidden');
        }
    };
}

function depositMoney(amount) {
    fetch(`https://${GetParentResourceName()}/depositMoney`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({amount: amount})
    });
}

function withdrawMoney(amount) {
    fetch(`https://${GetParentResourceName()}/withdrawMoney`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({amount: amount})
    });
}

// ====================================
// Shop Functions
// ====================================

function openShop(shopData) {
    console.log('Shop opened:', shopData);
    // Shop implementation would go here
}

// ====================================
// Modal Close Button Handlers
// ====================================

document.querySelectorAll('.close').forEach(closeBtn => {
    closeBtn.addEventListener('click', function() {
        this.parentElement.parentElement.classList.add('hidden');
    });
});

// Close modal when clicking outside
window.addEventListener('click', function(event) {
    const modals = document.querySelectorAll('.modal');
    modals.forEach(modal => {
        if (event.target == modal) {
            modal.classList.add('hidden');
        }
    });
});

console.log('Tomi Framework - Web UI betöltve ✓');
